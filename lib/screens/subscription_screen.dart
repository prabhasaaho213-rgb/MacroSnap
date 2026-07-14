import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  bool _subscribed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: isDark ? Colors.white : const Color(0xFF1E293B), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('MacroSnap Pro'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [MacroSnapTheme.emerald, MacroSnapTheme.emeraldLight],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: MacroSnapTheme.emerald.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 36),
              ),
              const SizedBox(height: 24),
              Text(
                'Unlock Full Access',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Everything you need to hit your goals',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 32),
              _buildFeatureRow(Icons.photo_camera_rounded, 'AI Photo Analysis', 'Snap & get instant macros from any meal', isDark),
              _buildFeatureRow(Icons.restaurant_rounded, 'Complete Food Database', '130+ Indian dishes with accurate nutrition', isDark),
              _buildFeatureRow(Icons.bar_chart_rounded, 'Daily Macro Tracking', 'Protein, carbs, fats & calorie goals', isDark),
              _buildFeatureRow(Icons.history_rounded, 'Meal History', 'Review everything you ate', isDark),
              _buildFeatureRow(Icons.cloud_rounded, 'Cloud Backup', 'Your data stays safe across devices', isDark),
              const SizedBox(height: 32),
              GlassCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '₹',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: MacroSnapTheme.emerald,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '1',
                            style: TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.w800,
                              color: isDark ? Colors.white : const Color(0xFF1E293B),
                              letterSpacing: -2,
                              height: 1,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              '/ month',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'That\'s just ₹0.03 per day',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: MacroSnapTheme.emerald.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Cancel anytime. No questions asked.',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: isDark ? Colors.white30 : const Color(0xFFCBD5E1),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: _subscribed
                        ? const LinearGradient(colors: [Color(0xFFCBD5E1), Color(0xFFE2E8F0)])
                        : const LinearGradient(
                            colors: [MacroSnapTheme.emerald, MacroSnapTheme.emeraldLight],
                          ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: _subscribed
                        ? []
                        : [
                            BoxShadow(
                              color: MacroSnapTheme.emerald.withValues(alpha: 0.3),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {
                        setState(() => _subscribed = !_subscribed);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(_subscribed ? 'Subscribed! Welcome to MacroSnap Pro.' : 'Subscription cancelled.'),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                        if (_subscribed) {
                          Future.delayed(const Duration(seconds: 1), () {
                            if (mounted) Navigator.pop(context);
                          });
                        }
                      },
                      child: Center(
                        child: Text(
                          _subscribed ? 'Subscribed ✓' : 'Subscribe Now — ₹1/month',
                          style: TextStyle(
                            color: _subscribed ? const Color(0xFF64748B) : Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (_subscribed) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => setState(() => _subscribed = false),
                      child: const Center(
                        child: Text(
                          'Cancel Subscription',
                          style: TextStyle(
                            color: MacroSnapTheme.rose,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: MacroSnapTheme.emerald.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: MacroSnapTheme.emerald, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white38 : const Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle_rounded, color: MacroSnapTheme.emerald, size: 22),
        ],
      ),
    );
  }
}
