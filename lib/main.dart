import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const FitTrackApp());

class FitTrackApp extends StatelessWidget {
  const FitTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.lime,
          surface: AppColors.surface,
        ),
        fontFamily: 'Roboto',
      ),
      home: const RootScreen(),
    );
  }
}

class AppColors {
  static const bg = Color(0xFF0D1014);
  static const surface = Color(0xFF161A20);
  static const surface2 = Color(0xFF1E242C);
  static const lime = Color(0xFFC8FF3C);
  static const blue = Color(0xFF5B8DEF);
  static const coral = Color(0xFFFF6B5E);
  static const text = Color(0xFFF4F6F8);
  static const muted = Color(0xFF8B92A0);
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;
  final _pages = const [DashboardPage(), ActivityPage(), WorkoutsPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: Color(0xFF232A33))),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            backgroundColor: Colors.transparent,
            indicatorColor: AppColors.lime.withValues(alpha: 0.16),
            labelTextStyle: WidgetStateProperty.all(
              const TextStyle(fontSize: 11, color: AppColors.muted),
            ),
          ),
          child: NavigationBar(
            height: 64,
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home_outlined, color: AppColors.muted), selectedIcon: Icon(Icons.home, color: AppColors.lime), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.show_chart_outlined, color: AppColors.muted), selectedIcon: Icon(Icons.show_chart, color: AppColors.lime), label: 'Activity'),
              NavigationDestination(icon: Icon(Icons.fitness_center_outlined, color: AppColors.muted), selectedIcon: Icon(Icons.fitness_center, color: AppColors.lime), label: 'Workouts'),
              NavigationDestination(icon: Icon(Icons.person_outline, color: AppColors.muted), selectedIcon: Icon(Icons.person, color: AppColors.lime), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Good morning,', style: TextStyle(color: AppColors.muted, fontSize: 14)),
                  SizedBox(height: 2),
                  Text('Alex Carter', style: TextStyle(color: AppColors.text, fontSize: 24, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Container(
              height: 46, width: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [AppColors.lime, AppColors.blue]),
              ),
              child: const Center(child: Text('AC', style: TextStyle(color: AppColors.bg, fontWeight: FontWeight.w700))),
            ),
          ],
        ),
        const SizedBox(height: 24),
        _RingsCard(),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(child: _StatCard(icon: Icons.directions_walk, label: 'Steps', value: '8,420', accent: AppColors.lime)),
            SizedBox(width: 12),
            Expanded(child: _StatCard(icon: Icons.local_fire_department, label: 'Calories', value: '612', accent: AppColors.coral)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: const [
            Expanded(child: _StatCard(icon: Icons.favorite, label: 'Heart rate', value: '72 bpm', accent: AppColors.coral)),
            SizedBox(width: 12),
            Expanded(child: _StatCard(icon: Icons.route, label: 'Distance', value: '5.9 km', accent: AppColors.blue)),
          ],
        ),
        const SizedBox(height: 24),
        const _SectionTitle('This week'),
        const SizedBox(height: 12),
        _WeeklyCard(),
        const SizedBox(height: 24),
        const _SectionTitle("Today's workout"),
        const SizedBox(height: 12),
        _WorkoutCard(),
      ],
    );
  }
}

class _RingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          SizedBox(
            height: 120, width: 120,
            child: CustomPaint(painter: _RingsPainter(move: 0.78, exercise: 0.62, stand: 0.9)),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _RingLegend(color: AppColors.lime, label: 'Move', value: '468 / 600 cal'),
                SizedBox(height: 14),
                _RingLegend(color: AppColors.blue, label: 'Exercise', value: '37 / 60 min'),
                SizedBox(height: 14),
                _RingLegend(color: AppColors.coral, label: 'Stand', value: '9 / 10 hr'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RingLegend extends StatelessWidget {
  final Color color;
  final String label, value;
  const _RingLegend({required this.color, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 10, width: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.text, fontWeight: FontWeight.w600, fontSize: 13)),
            Text(value, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class _RingsPainter extends CustomPainter {
  final double move, exercise, stand;
  _RingsPainter({required this.move, required this.exercise, required this.stand});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const stroke = 12.0, gap = 6.0;
    final rings = [
      [move, AppColors.lime, size.width / 2 - stroke / 2],
      [exercise, AppColors.blue, size.width / 2 - stroke / 2 - stroke - gap],
      [stand, AppColors.coral, size.width / 2 - stroke / 2 - 2 * (stroke + gap)],
    ];
    for (final r in rings) {
      final progress = r[0] as double;
      final color = r[1] as Color;
      final radius = r[2] as double;
      final bg = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = color.withValues(alpha: 0.15);
      canvas.drawCircle(center, radius, bg);
      final fg = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = color;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2, 2 * math.pi * progress, false, fg);
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter old) =>
      old.move != move || old.exercise != exercise || old.stand != stand;
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color accent;
  const _StatCard({required this.icon, required this.label, required this.value, required this.accent});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 36, width: 36,
            decoration: BoxDecoration(color: accent.withValues(alpha: 0.16), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(height: 14),
          Text(value, style: const TextStyle(color: AppColors.text, fontSize: 20, fontWeight: FontWeight.w700)),
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 12)),
        ],
      ),
    );
  }
}

class _WeeklyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    const values = [0.5, 0.8, 0.4, 0.95, 0.6, 0.75, 0.3];
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 14),
      decoration: _cardDecoration(),
      child: SizedBox(
        height: 140,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(7, (i) {
            final active = i == 3;
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 26,
                  height: 110 * values[i],
                  decoration: BoxDecoration(
                    color: active ? AppColors.lime : AppColors.surface2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(height: 8),
                Text(days[i], style: TextStyle(color: active ? AppColors.lime : AppColors.muted, fontSize: 12)),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E2A1A), Color(0xFF161A20)],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.lime.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            height: 52, width: 52,
            decoration: BoxDecoration(color: AppColors.lime, borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.directions_run, color: AppColors.bg),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Full Body HIIT', style: TextStyle(color: AppColors.text, fontSize: 16, fontWeight: FontWeight.w700)),
                SizedBox(height: 4),
                Text('32 min · 8 exercises · 420 cal', style: TextStyle(color: AppColors.muted, fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.play_circle_fill, color: AppColors.lime, size: 36),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) =>
      Text(text, style: const TextStyle(color: AppColors.text, fontSize: 17, fontWeight: FontWeight.w700));
}

BoxDecoration _cardDecoration() => BoxDecoration(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: const Color(0xFF232A33)),
    );

// Secondary tabs — presentable placeholders.

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});
  @override
  Widget build(BuildContext context) => const _ComingSoon(icon: Icons.show_chart, title: 'Activity', subtitle: 'Trends, history and personal records.');
}

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({super.key});
  @override
  Widget build(BuildContext context) => const _ComingSoon(icon: Icons.fitness_center, title: 'Workouts', subtitle: 'Browse and start guided sessions.');
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const _ComingSoon(icon: Icons.person, title: 'Profile', subtitle: 'Goals, devices and preferences.');
}

class _ComingSoon extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const _ComingSoon({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.lime, size: 44),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: AppColors.text, fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted)),
          ),
        ],
      ),
    );
  }
}
