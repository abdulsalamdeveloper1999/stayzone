import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/subscription_product.dart';
import '../cubit/subscription_cubit.dart';
import '../cubit/subscription_state.dart';

@RoutePage()
class PaywallPage extends StatefulWidget {
  const PaywallPage({super.key});

  @override
  State<PaywallPage> createState() => _PaywallPageState();
}

class _PaywallPageState extends State<PaywallPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionCubit>().loadOfferings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is SubscriptionPurchaseSuccess) {
            context.router.replaceAll([const MainRoute()]);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.blackPrimaryDark,
                AppTheme.highlightColor.withValues(alpha: 0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => context.router.maybePop(),
                    ),
                  ),

                  const Spacer(flex: 1),

                  // App icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.highlightColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      size: 40,
                      color: AppTheme.highlightColor,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Title
                  Text(
                    'Unlock Premium',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Master your focus with unlimited monk powers',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.7),
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      '"This isn\'t just a fee—it\'s a promise to yourself.\nYou are investing to save your time from distraction."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.highlightColor.withValues(alpha: 0.9),
                        fontFamily: AppTheme.fontFamily,
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Compact features
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCompactFeature('🧘‍♂️', 'Monk\nSquad'),
                      _buildCompactFeature('📊', 'Unlimited\nHistory'),
                      _buildCompactFeature('🌟', 'Advanced\nInsights'),
                      _buildCompactFeature('🎵', 'Premium\nSounds'),
                    ],
                  ),

                  const Spacer(flex: 2),

                  // Pricing cards
                  BlocBuilder<SubscriptionCubit, SubscriptionState>(
                    builder: (context, state) {
                      final isLoading = state is SubscriptionPurchasing;

                      if (state is SubscriptionLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (state is SubscriptionLoadedOfferings) {
                        final products = state.products;
                        if (products.isEmpty) {
                          return Text(
                            'No products available',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          );
                        }

                        // Sort functionality or find specific products if needed.
                        // Assuming order from logic: Annual, Monthly

                        return Column(
                          children: products.map((product) {
                            final isAnnual =
                                product.id.toLowerCase().contains('year') ||
                                product.id.toLowerCase().contains('annual');

                            // Highlight annual as recommended
                            final isRecommended = isAnnual;

                            String subtitle = '';
                            if (isAnnual) {
                              subtitle = 'Best Value';
                              // If possible calculate savings, but for now simple text
                            }

                            if (product.hasFreeTrial) {
                              subtitle = '7 Days Free Trial';
                            }

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildCompactPricingCard(
                                context,
                                product.title.isNotEmpty
                                    ? product.title
                                    : (isAnnual ? 'Yearly' : 'Monthly'),
                                product.priceString,
                                subtitle.isNotEmpty ? subtitle : null,
                                product,
                                isRecommended: isRecommended,
                                isLoading: isLoading,
                              ),
                            );
                          }).toList(),
                        );
                      }

                      // Fallback/Initial state
                      return const SizedBox.shrink();
                    },
                  ),

                  const SizedBox(height: 16),

                  // Skip button
                  TextButton(
                    onPressed: () {
                      context.router.replaceAll([const MainRoute()]);
                    },
                    child: Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppTheme.fontFamily,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Restore purchases
                  TextButton(
                    onPressed: () {
                      context.read<SubscriptionCubit>().restorePurchases();
                    },
                    child: Text(
                      'Restore Purchases',
                      style: TextStyle(
                        color: AppTheme.highlightColor,
                        fontSize: 14,
                        fontFamily: AppTheme.fontFamily,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Terms (Apple requirement)
                  Text(
                    'Auto-renewable. Cancel anytime in Settings.\nTerms of Service • Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white.withValues(alpha: 0.4),
                      fontFamily: AppTheme.fontFamily,
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompactFeature(String emoji, String text) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const SizedBox(height: 4),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.8),
            fontFamily: AppTheme.fontFamily,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildCompactPricingCard(
    BuildContext context,
    String title,
    String price,
    String? subtitle,
    SubscriptionProduct product, {
    bool isRecommended = false,
    bool isLoading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: isRecommended
            ? [
                BoxShadow(
                  color: AppTheme.highlightColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isRecommended
                    ? [
                        AppTheme.highlightColor.withValues(alpha: 0.3),
                        AppTheme.highlightColor.withValues(alpha: 0.15),
                      ]
                    : [
                        AppTheme.blackCardColor.withValues(alpha: 0.5),
                        AppTheme.blackCardColor.withValues(alpha: 0.3),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isRecommended
                    ? AppTheme.highlightColor.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.1),
                width: isRecommended ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: AppTheme.fontFamily,
                            ),
                          ),
                          if (isRecommended) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.successColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'BEST VALUE',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: AppTheme.fontFamily,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.highlightColor,
                          fontFamily: AppTheme.fontFamily,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withValues(alpha: 0.6),
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context
                                .read<SubscriptionCubit>()
                                .purchaseSubscription(product);
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRecommended
                          ? AppTheme.highlightColor
                          : Colors.white,
                      foregroundColor: isRecommended
                          ? Colors.white
                          : AppTheme.blackPrimaryDark,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Select',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: AppTheme.fontFamily,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
