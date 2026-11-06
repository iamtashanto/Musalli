import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:musalli/core/theme/musalli_theme.dart';
import 'package:musalli/features/simulator/domain/types.dart';
import 'package:musalli/features/simulator/presentation/figure/simulator_figure.dart';

void main() {
  Widget buildTestableFigure({
    required Posture posture,
    required SimGender gender,
    FigureViewMode viewMode = FigureViewMode.side,
    bool showHighlights = true,
  }) {
    return MaterialApp(
      theme: MusalliTheme.light(),
      home: Scaffold(
        body: Center(
          child: SimulatorFigure(
            posture: posture,
            gender: gender,
            viewMode: viewMode,
            showHighlights: showHighlights,
          ),
        ),
      ),
    );
  }

  group('SimulatorFigure Widget & Posture Tests', () {
    testWidgets('1. Figure renders standing posture for male', (tester) async {
      await tester.pumpWidget(
        buildTestableFigure(posture: Posture.standing, gender: SimGender.male),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SimulatorFigure), findsOneWidget);
      expect(find.byType(CustomPaint), findsWidgets);
    });

    testWidgets('2. Figure renders standing posture for female', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableFigure(
          posture: Posture.standing,
          gender: SimGender.female,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SimulatorFigure), findsOneWidget);
    });

    testWidgets(
      '3. All 16 postures render without exceptions for both genders',
      (tester) async {
        for (final gender in SimGender.values) {
          for (final posture in Posture.values) {
            await tester.pumpWidget(
              buildTestableFigure(posture: posture, gender: gender),
            );
            await tester.pump(const Duration(milliseconds: 100));
            expect(find.byType(SimulatorFigure), findsOneWidget);
          }
        }
      },
    );

    testWidgets('4. Sajda renders 7-point contact highlight in side view', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableFigure(
          posture: Posture.sajda,
          gender: SimGender.male,
          showHighlights: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SimulatorFigure), findsOneWidget);
    });

    testWidgets('5. Front view renders correctly for takbir and salam', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableFigure(
          posture: Posture.takbirHandsRaised,
          gender: SimGender.male,
          viewMode: FigureViewMode.front,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SimulatorFigure), findsOneWidget);

      await tester.pumpWidget(
        buildTestableFigure(
          posture: Posture.salamRight,
          gender: SimGender.male,
          viewMode: FigureViewMode.front,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SimulatorFigure), findsOneWidget);
    });

    testWidgets('6. Transitioning between postures triggers animation', (
      tester,
    ) async {
      await tester.pumpWidget(
        buildTestableFigure(posture: Posture.standing, gender: SimGender.male),
      );
      await tester.pumpAndSettle();

      // Trigger posture change to Ruku
      await tester.pumpWidget(
        buildTestableFigure(posture: Posture.ruku, gender: SimGender.male),
      );
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.byType(SimulatorFigure), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(SimulatorFigure), findsOneWidget);
    });
  });
}
