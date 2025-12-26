import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/services/board_exam_api_service.dart';
import '../../core/constants/app_constants.dart';

/// Board Exam Dashboard Screen
/// 
/// Shows the student's board exam preparation progress including:
/// - Current study mode (Normal/Prelims/Crunch)
/// - Chapter-wise progress with marks weightage
/// - Predicted score and days until exam
class BoardExamDashboardScreen extends ConsumerStatefulWidget {
  const BoardExamDashboardScreen({super.key});

  @override
  ConsumerState<BoardExamDashboardScreen> createState() => _BoardExamDashboardScreenState();
}

class _BoardExamDashboardScreenState extends ConsumerState<BoardExamDashboardScreen> {
  final BoardExamApiService _apiService = BoardExamApiService();
  
  bool _isLoading = true;
  String? _error;
  StudyModeData? _studyMode;
  CognitiveLoadConfig? _cognitiveConfig;
  List<ChapterProgress> _chapters = [];
  
  // Student config - in production, get from auth
  final String _studentId = 'student-123';
  final String _board = 'CBSE';
  final int _classLevel = 10;
  final DateTime _examDate = DateTime(2025, 3, 1);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Load study mode
      final modeResponse = await _apiService.getStudyMode(
        studentId: _studentId,
        board: _board,
        classLevel: _classLevel,
        examDate: _examDate,
      );
      _studyMode = modeResponse.data;

      // Load cognitive config
      _cognitiveConfig = await _apiService.getCognitiveLoadConfig(
        studentId: _studentId,
        classLevel: _classLevel,
      );

      // Load progress
      final progressResponse = await _apiService.getStudentProgress(
        studentId: _studentId,
        board: _board,
        classLevel: _classLevel,
      );
      _chapters = progressResponse.chapters;

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = e.toString();
      });
      
      // Use mock data for demo
      _useMockData();
    }
  }

  void _useMockData() {
    setState(() {
      _studyMode = StudyModeData(
        studentId: _studentId,
        board: _board,
        classLevel: _classLevel,
        daysUntilExam: _examDate.difference(DateTime.now()).inDays,
        currentMode: _examDate.difference(DateTime.now()).inDays <= 30 
            ? 'crunch' 
            : _examDate.difference(DateTime.now()).inDays <= 60 
                ? 'prelims' 
                : 'normal',
        modeConfig: {
          'description': 'Focus on high-weightage chapters',
          'max_interval': 14,
          'focus': 'Intensive revision',
        },
      );
      
      _cognitiveConfig = CognitiveLoadConfig(
        studentId: _studentId,
        classLevel: _classLevel,
        workingMemorySlots: 4.0,
        optimalSessionDuration: {
          'morning': 1.8,
          'afternoon': 1.4,
          'evening': 2.0,
          'night': 1.6,
        },
        breakFrequencyMinutes: 35,
      );
      
      // Sample chapters
      _chapters = _generateMockChapters();
      _isLoading = false;
      _error = null;
    });
  }

  List<ChapterProgress> _generateMockChapters() {
    final chapters = [
      ('Quadratic Equations', 10.0, 'High'),
      ('Trigonometry', 12.0, 'High'),
      ('Triangles', 9.0, 'High'),
      ('Arithmetic Progressions', 8.0, 'High'),
      ('Linear Equations', 8.0, 'Medium'),
      ('Circles', 8.0, 'Medium'),
      ('Real Numbers', 6.0, 'Medium'),
      ('Polynomials', 7.0, 'Medium'),
      ('Coordinate Geometry', 6.0, 'Medium'),
      ('Statistics', 6.0, 'Low'),
    ];

    return chapters.asMap().entries.map((entry) {
      final i = entry.key;
      final ch = entry.value;
      final retention = 0.3 + (i * 0.07);
      return ChapterProgress(
        chapterId: 'ch_$i',
        chapterName: ch.$1,
        chapterNumber: i + 1,
        subject: 'Mathematics',
        weightage: ch.$2,
        priorityLevel: ch.$3,
        masteryScore: retention * 100,
        retentionScore: retention,
        status: retention > 0.8 ? 'mastered' : retention > 0.5 ? 'in_progress' : 'at_risk',
        predictedMarks: ch.$2 * retention * 0.9,
      );
    }).toList();
  }

  @override
  void dispose() {
    _apiService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: _buildAppBar(),
      body: _isLoading 
          ? _buildLoadingState()
          : _error != null && _studyMode == null
              ? _buildErrorState()
              : _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Board Exam Prep',
            style: TextStyle(
              color: Colors.grey[800],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(
            '$_board Class $_classLevel',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh, color: Colors.grey),
          onPressed: _loadData,
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading your study plan...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Backend not connected',
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            const SizedBox(height: 8),
            Text(
              'Using demo data',
              style: TextStyle(color: Colors.grey[500]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _useMockData,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Continue with Demo'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    // Sort chapters by priority score
    final sortedChapters = List<ChapterProgress>.from(_chapters)
      ..sort((a, b) => b.priorityScore.compareTo(a.priorityScore));

    return RefreshIndicator(
      onRefresh: _loadData,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Study Mode Banner
            _buildStudyModeBanner().animate().fadeIn().slideY(begin: -0.2),
            
            const SizedBox(height: 20),
            
            // Stats Cards
            _buildStatsRow().animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
            
            const SizedBox(height: 20),
            
            // Cognitive Load Info
            if (_cognitiveConfig != null)
              _buildCognitiveLoadCard().animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 20),
            
            // Chapter Progress Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chapter-wise Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Sorted by Priority',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Priority Score Formula
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.functions, size: 16, color: Colors.purple[700]),
                  const SizedBox(width: 8),
                  Text(
                    'Priority = Marks × (1 - Retention)',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.purple[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Chapter List
            ...sortedChapters.asMap().entries.map((entry) {
              return _buildChapterCard(entry.value, entry.key)
                  .animate()
                  .fadeIn(delay: (300 + entry.key * 50).ms)
                  .slideX(begin: 0.1);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildStudyModeBanner() {
    if (_studyMode == null) return const SizedBox.shrink();
    
    final mode = _studyMode!;
    
    Color gradientStart;
    Color gradientEnd;
    IconData modeIcon;
    
    switch (mode.currentMode) {
      case 'crunch':
        gradientStart = const Color(0xFFEF4444);
        gradientEnd = const Color(0xFFEC4899);
        modeIcon = Icons.local_fire_department;
        break;
      case 'prelims':
        gradientStart = const Color(0xFFF59E0B);
        gradientEnd = const Color(0xFFEA580C);
        modeIcon = Icons.track_changes;
        break;
      default:
        gradientStart = const Color(0xFF3B82F6);
        gradientEnd = const Color(0xFF2563EB);
        modeIcon = Icons.auto_stories;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [gradientStart, gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradientStart.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(modeIcon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mode.modeLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mode.modeConfig['focus'] ?? 'Focus on your studies',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${mode.daysUntilExam}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'days left',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final masteredCount = _chapters.where((c) => c.status == 'mastered').length;
    final atRiskCount = _chapters.where((c) => c.status == 'at_risk' || c.status == 'not_started').length;
    final totalMarks = _chapters.fold(0.0, (sum, c) => sum + c.weightage);
    final predictedMarks = _chapters.fold(0.0, (sum, c) => sum + c.predictedMarks);
    final predictedPercent = totalMarks > 0 ? (predictedMarks / totalMarks * 100) : 0;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Predicted',
            '${predictedPercent.toStringAsFixed(0)}%',
            Icons.trending_up,
            Colors.purple,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Mastered',
            '$masteredCount/${_chapters.length}',
            Icons.check_circle_outline,
            Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'At Risk',
            '$atRiskCount',
            Icons.warning_amber_outlined,
            Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCognitiveLoadCard() {
    final config = _cognitiveConfig!;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.psychology, color: Colors.blue[700], size: 32),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cognitive Load Optimization',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Memory slots: ${config.workingMemorySlots.toStringAsFixed(1)} • '
                  'Best session: ${config.optimalSessionDuration['evening']?.toStringAsFixed(1)}h (evening) • '
                  'Break every ${config.breakFrequencyMinutes} min',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterCard(ChapterProgress chapter, int index) {
    Color statusColor;
    IconData statusIcon;
    String statusLabel;
    
    switch (chapter.status) {
      case 'mastered':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        statusLabel = 'Mastered';
        break;
      case 'in_progress':
        statusColor = Colors.blue;
        statusIcon = Icons.pending;
        statusLabel = 'In Progress';
        break;
      case 'at_risk':
        statusColor = Colors.orange;
        statusIcon = Icons.warning_amber;
        statusLabel = 'At Risk';
        break;
      default:
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        statusLabel = 'Not Started';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: chapter.status == 'at_risk' || chapter.status == 'not_started'
              ? Colors.red.withOpacity(0.3)
              : Colors.grey.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Priority indicator
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: chapter.priorityLevel == 'High' 
                      ? Colors.red 
                      : chapter.priorityLevel == 'Medium'
                          ? Colors.orange
                          : Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.chapterName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      chapter.subject,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              // Marks display
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: chapter.predictedMarks.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: chapter.retentionScore > 0.7 
                                ? Colors.green[700]
                                : chapter.retentionScore > 0.4
                                    ? Colors.orange[700]
                                    : Colors.red[700],
                          ),
                        ),
                        TextSpan(
                          text: '/${chapter.weightage.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'marks',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress bar
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: chapter.retentionScore,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation(statusColor),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(chapter.retentionScore * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Status and action
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, size: 14, color: statusColor),
                    const SizedBox(width: 4),
                    Text(
                      statusLabel,
                      style: TextStyle(
                        fontSize: 12,
                        color: statusColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  // Navigate to study mode
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Starting revision for ${chapter.chapterName}'),
                      backgroundColor: Colors.purple,
                    ),
                  );
                },
                icon: const Icon(Icons.play_arrow, size: 18),
                label: Text(
                  _studyMode?.currentMode == 'crunch' ? 'Quick Revise' : 'Study Now',
                ),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
