import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/retain_learn_theme.dart';

/// Landing Page - Matches Web RetainLearn design
/// 
/// Features:
/// - Large serif headline with "Notebook" in Teal italic
/// - Clean white/off-white background
/// - Pill-shaped teal CTA button
/// - AI Analysis mockup card
/// - Feature sections
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetainLearnTheme.paperOffWhite,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(child: _buildAppBar(context)),
            // Hero Section
            SliverToBoxAdapter(child: _HeroSection()),
            // Features Section
            SliverToBoxAdapter(child: _FeaturesSection()),
            // How It Works Section
            SliverToBoxAdapter(child: _HowItWorksSection()),
            // CTA Section
            SliverToBoxAdapter(child: _CTASection()),
            // Footer
            SliverToBoxAdapter(child: _Footer()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: RetainLearnTheme.paperWhite,
      child: Row(
        children: [
          // Logo
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: RetainLearnTheme.tealPrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.auto_stories,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'RetainLearn',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: RetainLearnTheme.textDark,
            ),
          ),
          const Spacer(),
          // Nav Links (Hidden on mobile, shown on larger screens)
          if (MediaQuery.of(context).size.width > 600) ...[
            TextButton(
              onPressed: () {},
              child: Text(
                'Features',
                style: TextStyle(color: RetainLearnTheme.textMedium),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'How it Works',
                style: TextStyle(color: RetainLearnTheme.textMedium),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Pricing',
                style: TextStyle(color: RetainLearnTheme.textMedium),
              ),
            ),
            const SizedBox(width: 16),
          ],
          // Dashboard Button
          FilledButton(
            onPressed: () => context.go('/login'),
            style: FilledButton.styleFrom(
              backgroundColor: RetainLearnTheme.tealPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Dashboard'),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 700;

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
      child: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildHeroText(context)),
                const SizedBox(width: 48),
                Expanded(child: _buildMockupCards(context)),
              ],
            )
          : Column(
              children: [
                _buildHeroText(context),
                const SizedBox(height: 40),
                _buildMockupCards(context),
              ],
            ),
    );
  }

  Widget _buildHeroText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: RetainLearnTheme.tealSurface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: RetainLearnTheme.tealPrimary.withOpacity(0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.auto_awesome,
                size: 14,
                color: RetainLearnTheme.tealPrimary,
              ),
              const SizedBox(width: 6),
              Text(
                'Next-Gen Adaptive Tutoring',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: RetainLearnTheme.tealDark,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Main Headline
        RichText(
          text: TextSpan(
            style: GoogleFonts.merriweather(
              fontSize: 36,
              fontWeight: FontWeight.w900,
              color: RetainLearnTheme.textDark,
              height: 1.2,
            ),
            children: [
              const TextSpan(text: 'Your\nIntelligent\n'),
              TextSpan(
                text: 'Notebook',
                style: GoogleFonts.merriweather(
                  fontStyle: FontStyle.italic,
                  color: RetainLearnTheme.tealPrimary,
                ),
              ),
              const TextSpan(text: ' for\nAdaptive\nLearning.'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Subtitle
        Text(
          'RetainLearn transforms your assignments, reports, and doubts into a personalized learning journey. Powered by Gemini AI to adapt to your unique style.',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: RetainLearnTheme.textMedium,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),

        // CTA Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: () => GoRouter.of(context).go('/signup'),
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('Start Your Journey'),
              style: FilledButton.styleFrom(
                backgroundColor: RetainLearnTheme.tealPrimary,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
            OutlinedButton(
              onPressed: () => GoRouter.of(context).go('/login'),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: RetainLearnTheme.grayBorder),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
              child: const Text('Take The Quiz'),
            ),
            // NEW: Board Exam Demo Button
            FilledButton.icon(
              onPressed: () => GoRouter.of(context).go('/board-exam'),
              icon: const Icon(Icons.school, size: 18),
              label: const Text('Board Exam Demo'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Social Proof
        Row(
          children: [
            // Avatar stack
            SizedBox(
              width: 80,
              height: 32,
              child: Stack(
                children: List.generate(4, (i) {
                  return Positioned(
                    left: i * 18.0,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: RetainLearnTheme.tealSurface,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        Icons.person,
                        size: 16,
                        color: RetainLearnTheme.tealPrimary,
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(width: 12),
            RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: RetainLearnTheme.textMedium,
                ),
                children: [
                  const TextSpan(text: 'Joined by '),
                  TextSpan(
                    text: '1,200+',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: RetainLearnTheme.textDark,
                    ),
                  ),
                  const TextSpan(text: ' learners today'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMockupCards(BuildContext context) {
    return Column(
      children: [
        // AI Analysis Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: RetainLearnTheme.paperWhite,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: RetainLearnTheme.tealSurface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.analytics,
                      color: RetainLearnTheme.tealPrimary,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Analysis',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: RetainLearnTheme.textDark,
                        ),
                      ),
                      Text(
                        'Assignment ID: #4421',
                        style: TextStyle(
                          fontSize: 12,
                          color: RetainLearnTheme.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Progress bars
              _buildProgressBar(0.85, RetainLearnTheme.tealPrimary),
              const SizedBox(height: 8),
              _buildProgressBar(0.6, RetainLearnTheme.tealLight),
              const SizedBox(height: 16),
              // AI Message bubble
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: RetainLearnTheme.tealSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '"I\'ve analyzed your logic in the quadratic formula. You missed a negative sign in the discriminant—let me show you why."',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                    color: RetainLearnTheme.textMedium,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Your Style Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: RetainLearnTheme.paperWhite,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Style',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: RetainLearnTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.shade50,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '88%',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Visual',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Content adapted for diagrams',
                              style: TextStyle(
                                fontSize: 11,
                                color: RetainLearnTheme.textLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(double progress, Color color) {
    return Container(
      height: 8,
      decoration: BoxDecoration(
        color: RetainLearnTheme.grayBorder,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _FeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final features = [
      (Icons.auto_awesome, 'AI-Powered Analysis', 'Get personalized feedback on your assignments'),
      (Icons.document_scanner, 'Report Card Scanner', 'Scan and track your grades over time'),
      (Icons.record_voice_over, 'Voice Reading', 'Listen to your study materials'),
      (Icons.psychology, 'Learning Style Quiz', 'Discover how you learn best'),
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      color: RetainLearnTheme.paperWhite,
      child: Column(
        children: [
          Text(
            'Powerful Features',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Everything you need to excel in learning',
            style: TextStyle(color: RetainLearnTheme.textMedium),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: features.map((f) {
              return SizedBox(
                width: 300,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: RetainLearnTheme.paperOffWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: RetainLearnTheme.grayBorder),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: RetainLearnTheme.tealSurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(f.$1, color: RetainLearnTheme.tealPrimary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              f.$2,
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              f.$3,
                              style: TextStyle(
                                fontSize: 13,
                                color: RetainLearnTheme.textMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = [
      ('1', 'Upload Your Sources', 'Add assignments, reports, notes, or doubts'),
      ('2', 'AI Analyzes Content', 'Gemini AI understands your learning needs'),
      ('3', 'Get Personalized Help', 'Receive tailored feedback and explanations'),
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            'How It Works',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: steps.map((s) {
              return SizedBox(
                width: 280,
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: RetainLearnTheme.tealPrimary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          s.$1,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      s.$2,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      s.$3,
                      style: TextStyle(
                        fontSize: 14,
                        color: RetainLearnTheme.textMedium,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _CTASection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            RetainLearnTheme.tealPrimary,
            RetainLearnTheme.tealDark,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Transform Your Learning?',
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Join thousands of students already using RetainLearn',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () => GoRouter.of(context).go('/signup'),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: RetainLearnTheme.tealPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text('Get Started Free'),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: RetainLearnTheme.paperWhite,
      child: Column(
        children: [
          Divider(color: RetainLearnTheme.grayBorder),
          const SizedBox(height: 16),
          Text(
            '© 2024 RetainLearn. Powered by Gemini AI.',
            style: TextStyle(
              fontSize: 13,
              color: RetainLearnTheme.textLight,
            ),
          ),
        ],
      ),
    );
  }
}
