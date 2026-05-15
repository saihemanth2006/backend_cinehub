import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';
import 'dart:async';
import '../../models/models.dart';
import '../../services/auth_service.dart';
import '../../widgets/media_viewer.dart';

// ─────────────────────────────────────────────────────────────
//  DESIGN TOKENS
// ─────────────────────────────────────────────────────────────
class _C {
  static const bg = Color(0xFF06060E);
  static const surface = Color(0xFF0C0C18);
  static const card = Color(0xFF111120);
  static const cardBorder = Color(0xFF1A1A2E);
  static const accent = Color(0xFF7B5CFF);
  static const accentSoft = Color(0xFF9B7FFF);
  static const rose = Color(0xFFFF3D6B);
  static const amber = Color(0xFFFFA726);
  static const teal = Color(0xFF00BFA5);
  static const textPrimary = Color(0xFFEEECFF);
  static const textSec = Color(0xFF8884AA);
  static const textMuted = Color(0xFF4A4870);
}

// ─────────────────────────────────────────────────────────────
//  DATA MODELS
// ─────────────────────────────────────────────────────────────
class _Featured {
  final String title, subtitle, genre, badge, cta;
  final Color c1, c2;
  final IconData icon;
  const _Featured(this.title, this.subtitle, this.genre, this.badge, this.cta,
      this.c1, this.c2, this.icon);
}

class _Post {
  final String name, handle, ago, body;
  final String? id;
  final String? authorId;
  final String? imageLabel;
  final Color avatarColor;
  final bool verified, filmmaker;
  final String? genre;
  final List<String> tags;
  int likes;
  final int comments, shares, views;
  bool liked, bookmarked, following;

  _Post({
    required this.name,
    required this.handle,
    required this.ago,
    required this.body,
    this.imageLabel,
    required this.avatarColor,
    this.verified = false,
    this.filmmaker = false,
    this.genre,
    this.tags = const [],
    required this.likes,
    required this.comments,
    required this.shares,
    required this.views,
    this.id,
    this.authorId,
    this.liked = false,
    this.bookmarked = false,
    this.following = false,
  });
}

// ─────────────────────────────────────────────────────────────
//  HOME PAGE
// ─────────────────────────────────────────────────────────────
class HomePage extends StatefulWidget {
  final VoidCallback? onNavigateToMessages;
  final int unreadMessages;
  final List<ProfileData> allProfiles;

  const HomePage({
    super.key,
    this.onNavigateToMessages,
    this.unreadMessages = 0,
    required this.allProfiles,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Search
  bool _searchExpanded = true;
  final _searchCtrl = TextEditingController();
  String _query = '';
  static const double _scrollThreshold = 60.0;

  // Category
  String _cat = 'All';
  static const _cats = [
    'All', 'Trending', 'New Releases', 'Festivals',
    'Drama', 'Thriller', 'Documentary', 'Sci-Fi', 'Indie'
  ];

  // Carousel
  late PageController _pageCtrl;
  int _page = 0;
  Timer? _autoTimer;

  // Feed
  final _scrollCtrl = ScrollController();
  late List<_Post> _posts;
  bool _loadingMore = false;
  int _feedPage = 1;
  bool _hasMoreFeed = true;

  // Animations
  late AnimationController _shimmer, _pulse;

  static const _featured = [
    _Featured('Kalki 2898-AD', 'Sci-Fi Epic · 3hr 1min', 'Sci-Fi', 'TRENDING',
        'Watch Now', Color(0xFF7B5CFF), Color(0xFF3A1FA0), Icons.movie_rounded),
    _Featured('Stree 2', 'Horror Comedy · Hindi', 'Horror', 'HOT',
        'Watch Now', Color(0xFFFF3D6B), Color(0xFF8B0024), Icons.local_movies_rounded),
    _Featured('MAMI 2025', 'Film Festival · Mumbai', 'Festival', 'LIVE',
        'Register', Color(0xFF00BFA5), Color(0xFF004D40), Icons.emoji_events_rounded),
    _Featured('Indie Lens', 'Short Films · All Genres', 'Indie', 'NEW',
        'Explore', Color(0xFFFFA726), Color(0xFF6D3400), Icons.video_library_rounded),
    _Featured('Sundance 2025', 'World Cinema · Drama', 'Drama', 'FEATURED',
        'Apply', Color(0xFF00D4FF), Color(0xFF003356), Icons.public_rounded),
  ];

  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController();
    _shimmer = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat();
    _pulse = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat(reverse: true);
    _posts = [];
    _fetchFeedInitial();
    _scrollCtrl.addListener(_onScroll);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoTimer =
        Timer.periodic(const Duration(seconds: 3, milliseconds: 500), (_) {
      if (!mounted || !_pageCtrl.hasClients) return;
      final next = (_page + 1) % _featured.length;
      _pageCtrl.animateToPage(next,
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubic);
    });
  }

  void _onScroll() {
    // ── Collapse / expand search on scroll ──────────────────
    final scrolled = _scrollCtrl.offset > _scrollThreshold;
    if (scrolled && _searchExpanded) {
      setState(() => _searchExpanded = false);
    } else if (!scrolled && !_searchExpanded) {
      setState(() => _searchExpanded = true);
    }

    // ── Infinite load ────────────────────────────────────────
    if (_scrollCtrl.position.pixels >=
            _scrollCtrl.position.maxScrollExtent - 300 &&
        !_loadingMore) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (!_hasMoreFeed) return;
    setState(() => _loadingMore = true);
    _feedPage += 1;
    final newPosts = await _fetchFeed(page: _feedPage);
    if (!mounted) return;
    setState(() {
      _posts.addAll(newPosts);
      _loadingMore = false;
      if (newPosts.isEmpty) _hasMoreFeed = false;
    });
  }

  Future<void> _onRefresh() async {
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    _feedPage = 1;
    _hasMoreFeed = true;
    final fresh = await _fetchFeed(page: 1);
    if (!mounted) return;
    setState(() => _posts = fresh);
  }

  Future<void> _fetchFeedInitial() async {
    final list = await _fetchFeed(page: 1);
    if (!mounted) return;
    setState(() {
      _posts = list;
      _feedPage = 1;
      _hasMoreFeed = list.length >= 20;
    });
  }

  Future<List<_Post>> _fetchFeed({int page = 1, int limit = 20}) async {
    try {
      final svc = AuthService();
      final raw = await svc.fetchFeed(page: page, limit: limit);
      final meId = svc.user != null ? svc.user!['_id']?.toString() : null;
      final mapped = <_Post>[];
      for (final p in raw) {
        final author = p['author'] is Map ? Map<String, dynamic>.from(p['author']) : <String, dynamic>{};
        final authorId = author['_id']?.toString();
        if (meId != null && authorId == meId) continue; // skip current user's posts
        final name = author['fullName'] ?? author['name'] ?? 'Unknown';
        final username = author['username'] ?? (authorId != null ? authorId.substring(0, 6) : 'user');
        final content = p['content'] ?? '';
        final media = p['media'];
        String? imageLabel;
        if (media is List && media.isNotEmpty) {
          final first = media.first;
          if (first is String && first.isNotEmpty) imageLabel = first;
        }
        final likes = (p['likesCount'] ?? p['likes'] ?? 0) as int;
        final comments = (p['commentsCount'] ?? 0) as int;
        final genre = p['genre'] as String?;
        final liked = (p['liked'] ?? false) as bool;
        final following = (author['isFollowed'] ?? false) as bool;
        mapped.add(_Post(
          name: name,
          handle: '@' + username,
          ago: 'just now',
          body: content,
          imageLabel: imageLabel,
          avatarColor: const Color(0xFF7C3AED),
          verified: false,
          filmmaker: false,
          genre: genre,
          tags: const [],
          likes: likes,
          comments: comments,
          shares: 0,
          views: 0,
          id: p['_id']?.toString(),
          authorId: authorId,
        )..liked = liked..following = following);
      }
      return mapped;
    } catch (_) {
      return [];
    }
  }

  List<_Post> _buildPosts({int seed = 0}) {
    final rng = Random(seed);
    final data = [
      (
        name: 'Meera Krishnan',
        handle: '@meera.lens',
        body:
            'Just wrapped our 21-day shoot across Kerala backwaters 🎬\n\nEvery frame felt like a painting. Submitting to MAMI — fingers crossed! 🙏',
        img: 'BACKWATERS · Kerala',
        genre: 'Drama',
        tags: ['#IndieFilm', '#Kerala', '#MAMI2025'],
        color: const Color(0xFF7C3AED),
        v: true,
        f: true,
        views: 42800
      ),
      (
        name: 'Arjun Mehta',
        handle: '@arjun.director',
        body:
            'Acting tip that changed everything:\n\nStop trying to "act" — start trying to "live" in the scene. Your body knows what to do when your mind gets out of the way. 🎭',
        img: null,
        genre: null,
        tags: ['#ActingTips', '#FilmIndustry'],
        color: const Color(0xFF1D4ED8),
        v: true,
        f: false,
        views: 19200
      ),
      (
        name: 'Priya Nair Films',
        handle: '@priya.nair.films',
        body:
            'OPEN CALL: Casting for psychological thriller "The Last Signal"\n\n• Lead actress (25–35)\n• Supporting cast (any age)\n• Raw talent welcome 🎬',
        img: 'CASTING ROOM · Mumbai',
        genre: 'Thriller',
        tags: ['#Casting', '#OpenCall', '#Mumbai'],
        color: const Color(0xFFBE185D),
        v: false,
        f: true,
        views: 88500
      ),
      (
        name: 'Ravi Sharma DOP',
        handle: '@ravi_dop',
        body:
            'Golden hour in Rajasthan is something else entirely ☀️\n\n4am call time. 3 minutes of magic. The Thar desert has a soul.',
        img: 'GOLDEN HOUR · Thar Desert',
        genre: 'Documentary',
        tags: ['#Cinematography', '#GoldenHour', '#ARRI'],
        color: const Color(0xFF92400E),
        v: true,
        f: true,
        views: 31600
      ),
      (
        name: 'Aisha Kapoor',
        handle: '@aisha.scripts',
        body:
            'My screenplay "Lighthouse" just placed top 10 at Nicholl Fellowship 🏆\n\nThree years of rewrites. 47 drafts. Countless rejections. And here we are. ✍️',
        img: null,
        genre: 'Thriller',
        tags: ['#Screenwriting', '#NichollFellowship'],
        color: const Color(0xFF0369A1),
        v: true,
        f: false,
        views: 24100
      ),
      (
        name: 'Lucas Fernandez',
        handle: '@lucas.frames',
        body:
            'Built our entire VFX pipeline in Blender for under ₹5000 💻\n\nIndie doesn\'t mean low quality — it means creative problem solving. Full tutorial dropping this weekend 🔥',
        img: 'VFX BREAKDOWN · Blender',
        genre: 'Sci-Fi',
        tags: ['#VFX', '#Blender', '#IndieFilm'],
        color: const Color(0xFF065F46),
        v: false,
        f: true,
        views: 56300
      ),
    ];
    return List.generate(data.length, (i) {
      final d = data[(i + seed ~/ data.length) % data.length];
        return _Post(
        name: d.name,
        handle: d.handle,
        ago: '${rng.nextInt(22) + 1}h',
        body: d.body,
        imageLabel: d.img,
        avatarColor: d.color,
        verified: d.v,
        filmmaker: d.f,
        genre: d.genre,
        tags: d.tags,
        likes: rng.nextInt(9800) + 500,
        comments: rng.nextInt(980) + 40,
        shares: rng.nextInt(490) + 20,
        views: d.views + rng.nextInt(5000),
          id: null,
          authorId: null,
      );
    });
  }

  // ── Filtered profiles for search ─────────────────────────────
  List<ProfileData> get _searchResults {
    if (_query.isEmpty) return [];
    final q = _query.toLowerCase();
    return widget.allProfiles
        .where((p) =>
            p.name.toLowerCase().contains(q) ||
            p.role.toLowerCase().contains(q) ||
            p.skills.any((s) => s.toLowerCase().contains(q)) ||
            p.type.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _pageCtrl.dispose();
    _shimmer.dispose();
    _pulse.dispose();
    _scrollCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  // ─────────────────────── BUILD ────────────────────────────
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _C.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────
            _buildHeader(),

            // ── Category chips ───────────────────────────────
            _buildCategories(),

            // ── Scrollable body with floating search ─────────
            Expanded(
              child: Stack(
                children: [
                  // ── Main feed ────────────────────────────────
                  RefreshIndicator(
                    color: _C.accentSoft,
                    backgroundColor: _C.card,
                    displacement: 50,
                    strokeWidth: 2,
                    onRefresh: _onRefresh,
                    child: CustomScrollView(
                      controller: _scrollCtrl,
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      slivers: [
                        // Spacer so content starts below search bar
                        const SliverToBoxAdapter(
                            child: SizedBox(height: 68)),

                        // Featured Carousel
                        SliverToBoxAdapter(child: _buildCarousel()),

                        // Section label
                        SliverToBoxAdapter(child: _buildSectionLabel()),

                        // Instagram-style posts (hidden when searching)
                        if (_query.isEmpty)
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) {
                                if (i >= _posts.length) {
                                  return _loadingMore
                                      ? _buildShimmerPost()
                                      : const SizedBox(height: 80);
                                }
                                final p = _posts[i];
                                return _InstagramPost(
                                  key: ValueKey('post_$i'),
                                  post: p,
                                  index: i,
                                  onLike: () async {
                                    // optimistic UI update
                                    setState(() {
                                      p.liked = !p.liked;
                                      p.likes += p.liked ? 1 : -1;
                                    });
                                    HapticFeedback.lightImpact();
                                    // attempt backend call; if fails, revert
                                    try {
                                                              if (p.id == null) return;
                                                              final auth = AuthService();
                                                              final success = p.liked
                                                                  ? await auth.likePost(p.id!)
                                                                  : await auth.unlikePost(p.id!);
                                      if (!success && mounted) {
                                        setState(() {
                                          p.liked = !p.liked;
                                          p.likes += p.liked ? 1 : -1;
                                        });
                                      }
                                    } catch (_) {}
                                  },
                                  onBookmark: () {
                                    setState(() => p.bookmarked = !p.bookmarked);
                                    HapticFeedback.selectionClick();
                                  },
                                  onFollow: () async {
                                    setState(() => p.following = !p.following);
                                    try {
                                      if (p.authorId == null) return;
                                      final auth = AuthService();
                                      final success = p.following
                                          ? await auth.follow(p.authorId!)
                                          : await auth.unfollow(p.authorId!);
                                      if (!success && mounted) {
                                        setState(() => p.following = !p.following);
                                      }
                                    } catch (_) {}
                                  },
                                );
                              },
                              childCount: _posts.length + (_hasMoreFeed ? 1 : 0),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // ── Profile search results overlay ────────────
                  if (_query.isNotEmpty)
                    Positioned(
                      top: 68,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _buildProfileResults(),
                    ),

                  // ── Floating search bar ───────────────────────
                  Positioned(
                    top: 8,
                    right: 20,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                      width: _searchExpanded ? sw - 40 : 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: _C.card,
                        borderRadius: BorderRadius.circular(
                            _searchExpanded ? 20 : 26),
                        border: Border.all(
                          color: _searchExpanded
                              ? _C.accent.withOpacity(0.45)
                              : _C.cardBorder,
                          width: _searchExpanded ? 1.0 : 0.8,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _searchExpanded
                                ? _C.accent.withOpacity(0.12)
                                : Colors.black.withOpacity(0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: _searchExpanded
                            ? _buildExpandedSearch()
                            : _buildCollapsedSearch(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Expanded search bar ─────────────────────────────────────
  Widget _buildExpandedSearch() {
    return ClipRect(
      key: const ValueKey('expanded'),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0),
          child: Row(
            children: [
              const SizedBox(width: 14),
              const Icon(Icons.search_rounded, color: _C.accent, size: 20),
              const SizedBox(width: 10),
              SizedBox(
                width: 200,
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(
                      color: _C.textPrimary, fontSize: 13),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search films, directors, talent...',
                    hintStyle:
                        TextStyle(color: _C.textMuted, fontSize: 13),
                    isDense: true,
                  ),
                ),
              ),
              if (_query.isNotEmpty)
                IconButton(
                  icon: Icon(Icons.close_rounded,
                      color: _C.textSec.withOpacity(0.7), size: 18),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _query = '');
                  },
                ),
              IconButton(
                icon: Icon(Icons.chevron_right_rounded,
                    color: _C.textSec.withOpacity(0.6)),
                onPressed: () =>
                    setState(() => _searchExpanded = false),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Collapsed search (round icon) ──────────────────────────
  Widget _buildCollapsedSearch() {
    return GestureDetector(
      key: const ValueKey('collapsed'),
      onTap: () => setState(() => _searchExpanded = true),
      child: Center(
        child: Icon(Icons.search_rounded,
            color: _C.textPrimary.withOpacity(0.8), size: 22),
      ),
    );
  }

  // ── Profile search results ──────────────────────────────────
  Widget _buildProfileResults() {
    final results = _searchResults;
    return Container(
      color: _C.bg,
      child: results.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search_off_rounded,
                      size: 52, color: _C.textMuted.withOpacity(0.4)),
                  const SizedBox(height: 12),
                  Text(
                    'No profiles found for "$_query"',
                    style: const TextStyle(
                        color: _C.textSec,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Try searching by name, role or skill',
                    style:
                        TextStyle(color: _C.textMuted, fontSize: 12),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
              physics: const BouncingScrollPhysics(),
              itemCount: results.length,
              itemBuilder: (_, i) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SearchProfileCard(profile: results[i]),
              ),
            ),
    );
  }

  // ── Header ──────────────────────────────────────────────────
  //
  //  ╔══════════════════════════════════════════════════════════╗
  //  ║  CHANGE: LIVE badge → + (Create Post) button            ║
  //  ╚══════════════════════════════════════════════════════════╝
  Widget _buildHeader() {
    return Container(
      color: _C.bg,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Row(
        children: [
          // ── + Create Post button (replaces LIVE badge) ──────
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              // TODO: Replace with your actual PostPage navigation, e.g.:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (_) => const PostPage()),
              // );
              _showCreatePostSheet(context);
            },
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_C.accent, Color(0xFF9B4FE0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: _C.accent.withOpacity(0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // ── App name ────────────────────────────────────────
          ShaderMask(
            shaderCallback: (b) =>
                const LinearGradient(colors: [_C.accentSoft, _C.rose])
                    .createShader(b),
            child: const Text(
              'CineHub',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.2),
            ),
          ),

          const Spacer(),

          // ── Messages button (navigates to Messages tab) ─────
          _HeaderBtn(
            icon: Icons.chat_bubble_outline_rounded,
            badge: widget.unreadMessages,
            onTap: () {
              HapticFeedback.selectionClick();
              widget.onNavigateToMessages?.call();
            },
          ),
          const SizedBox(width: 8),

          // ── Notifications ───────────────────────────────────
          _HeaderBtn(icon: Icons.notifications_none_rounded, badge: 7),
        ],
      ),
    );
  }

  // ── Create Post bottom sheet ────────────────────────────────
  //  Replace this with a full-screen PostPage push if you prefer.
  void _showCreatePostSheet(BuildContext context) {
    // await result from sheet; newly created post will be returned and inserted into feed
    showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _CreatePostSheet(),
    ).then((created) {
      if (created != null && mounted) {
        // Map created post (backend shape) into local _Post model where possible
        setState(() {
          _posts.insert(0, _Post(
            name: created['author']?['fullName'] ?? 'You',
            handle: '@' + (created['author']?['username'] ?? 'me'),
            ago: 'just now',
            body: created['content'] ?? '',
            imageLabel: null,
            avatarColor: const Color(0xFF7C3AED),
            verified: false,
            filmmaker: false,
            genre: created['genre'],
            tags: const [],
            likes: created['likesCount'] ?? 0,
            comments: created['commentsCount'] ?? 0,
            shares: 0,
            views: 0,
            id: created['_id']?.toString(),
            authorId: created['author']?['_id']?.toString(),
          ));
        });
      }
    });
  }

  // ── Category chips ───────────────────────────────────────────
  Widget _buildCategories() {
    return Container(
      color: _C.bg,
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(14, 6, 14, 4),
        physics: const BouncingScrollPhysics(),
        itemCount: _cats.length,
        itemBuilder: (_, i) {
          final sel = _cats[i] == _cat;
          return GestureDetector(
            onTap: () {
              setState(() => _cat = _cats[i]);
              HapticFeedback.selectionClick();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.only(right: 8),
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                gradient: sel
                    ? const LinearGradient(
                        colors: [_C.accent, Color(0xFF9B4FE0)])
                    : null,
                color: sel ? null : _C.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: sel ? _C.accent : _C.cardBorder, width: 0.8),
              ),
              child: Text(
                _cats[i],
                style: TextStyle(
                  color: sel ? Colors.white : _C.textSec,
                  fontSize: 12,
                  fontWeight: sel ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Flipkart-style carousel ──────────────────────────────────
  Widget _buildCarousel() {
    return Column(
      children: [
        const SizedBox(height: 12),
        SizedBox(
          height: 216,
          child: PageView.builder(
            controller: _pageCtrl,
            onPageChanged: (p) => setState(() => _page = p),
            itemCount: _featured.length,
            itemBuilder: (_, i) => _FeaturedCard(
                featured: _featured[i],
                pageController: _pageCtrl,
                pageIndex: i),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_featured.length, (i) {
            final sel = i == _page;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: sel ? 22 : 6,
              height: 6,
              decoration: BoxDecoration(
                gradient: sel
                    ? const LinearGradient(colors: [_C.accent, _C.rose])
                    : null,
                color: sel ? null : _C.cardBorder,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // ── Section label ────────────────────────────────────────────
  Widget _buildSectionLabel() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [_C.accent, _C.rose],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        const Text('Latest in Film',
            style: TextStyle(
                color: _C.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w700)),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _C.card,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _C.cardBorder, width: 0.8),
            ),
            child: const Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.tune_rounded, color: _C.textSec, size: 14),
              SizedBox(width: 4),
              Text('Filter',
                  style: TextStyle(
                      color: _C.textSec,
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ]),
          ),
        ),
      ]),
    );
  }

  // ── Shimmer skeleton post ────────────────────────────────────
  Widget _buildShimmerPost() {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, __) {
        final s = LinearGradient(
          begin: Alignment(-1.5 + _shimmer.value * 3, 0),
          end: Alignment(0.5 + _shimmer.value * 3, 0),
          colors: const [
            Color(0xFF111120),
            Color(0xFF1A1A2E),
            Color(0xFF111120)
          ],
        );
        return Container(
          margin: const EdgeInsets.only(bottom: 2),
          color: _C.card,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, gradient: s)),
                const SizedBox(width: 12),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 130,
                          height: 11,
                          decoration: BoxDecoration(
                              gradient: s,
                              borderRadius: BorderRadius.circular(5))),
                      const SizedBox(height: 6),
                      Container(
                          width: 90,
                          height: 9,
                          decoration: BoxDecoration(
                              gradient: s,
                              borderRadius: BorderRadius.circular(5))),
                    ]),
              ]),
            ),
            Container(
                height: 280, decoration: BoxDecoration(gradient: s)),
            const SizedBox(height: 60),
          ]),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  CREATE POST BOTTOM SHEET
//  ╔══════════════════════════════════════════════════════════╗
//  ║  NEW: shown when + button is tapped                     ║
//  ║  Replace with a full PostPage push if you prefer        ║
//  ╚══════════════════════════════════════════════════════════╝
// ─────────────────────────────────────────────────────────────
class _CreatePostSheet extends StatefulWidget {
  const _CreatePostSheet();

  @override
  State<_CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<_CreatePostSheet> {
  final _ctrl = TextEditingController();
  String _selectedGenre = 'Drama';
  bool _addMedia = false;
  final List<String> _selectedMediaPaths = [];
  final List<String> _uploadedMediaUrls = [];
  bool _uploading = false;

  static const _genres = [
    'Drama', 'Thriller', 'Documentary', 'Sci-Fi',
    'Comedy', 'Horror', 'Indie', 'Festival'
  ];

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _pickMedia() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'mp4', 'mov', 'avi', 'webm'],
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path == null) return;

        setState(() => _uploading = true);

        try {
          final auth = AuthService();
          final url = await auth.uploadMediaFile(file.path!, file.name);
          
          if (url != null) {
            setState(() {
              _uploadedMediaUrls.add(url);
              _addMedia = true;
              _uploading = false;
            });
          } else {
            setState(() => _uploading = false);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to upload media')),
              );
            }
          }
        } catch (e) {
          setState(() => _uploading = false);
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Upload error: $e')),
            );
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _removeMedia(int index) {
    setState(() {
      _uploadedMediaUrls.removeAt(index);
      if (_uploadedMediaUrls.isEmpty) {
        _addMedia = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scrollCtrl) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0C0C18),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          children: [
            // ── Handle ────────────────────────────────────────
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A3E),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // ── Title bar ─────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [_C.accent, Color(0xFF9B4FE0)]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.edit_rounded,
                        color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Create Post',
                    style: TextStyle(
                        color: _C.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.close_rounded,
                          color: _C.textSec, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Scrollable body ───────────────────────────────
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Text field
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF111120),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: const Color(0xFF1A1A2E), width: 0.8),
                    ),
                    child: TextField(
                      controller: _ctrl,
                      maxLines: 5,
                      style: const TextStyle(
                          color: _C.textPrimary, fontSize: 14, height: 1.6),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText:
                            'Share your film journey, casting call, or behind-the-scenes moment...',
                        hintStyle: TextStyle(
                            color: _C.textMuted, fontSize: 14, height: 1.6),
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Genre picker
                  const Text('Genre',
                      style: TextStyle(
                          color: _C.textSec,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _genres.map((g) {
                      final sel = g == _selectedGenre;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedGenre = g),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            gradient: sel
                                ? const LinearGradient(colors: [
                                    _C.accent,
                                    Color(0xFF9B4FE0)
                                  ])
                                : null,
                            color: sel ? null : const Color(0xFF111120),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: sel
                                    ? _C.accent
                                    : const Color(0xFF1A1A2E),
                                width: 0.8),
                          ),
                          child: Text(g,
                              style: TextStyle(
                                  color: sel ? Colors.white : _C.textSec,
                                  fontSize: 12,
                                  fontWeight: sel
                                      ? FontWeight.w700
                                      : FontWeight.w500)),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),

                  // Add media row
                  GestureDetector(
                    onTap: _uploading ? null : _pickMedia,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _addMedia
                            ? _C.accent.withOpacity(0.08)
                            : const Color(0xFF111120),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: _addMedia
                              ? _C.accent.withOpacity(0.4)
                              : const Color(0xFF1A1A2E),
                          width: 0.8,
                        ),
                      ),
                      child: Row(children: [
                        _uploading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(
                                _addMedia
                                    ? Icons.photo_rounded
                                    : Icons.add_photo_alternate_outlined,
                                color: _addMedia ? _C.accentSoft : _C.textSec,
                                size: 20,
                              ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _addMedia
                                    ? 'Media attached (${_uploadedMediaUrls.length})'
                                    : 'Add photo / video',
                                style: TextStyle(
                                    color: _addMedia ? _C.accentSoft : _C.textSec,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600),
                              ),
                              if (_uploadedMediaUrls.isNotEmpty)
                                Text(
                                  'Tap to change',
                                  style: TextStyle(
                                    color: _C.textMuted,
                                    fontSize: 11,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (_addMedia)
                          const Icon(Icons.check_circle_rounded,
                              color: _C.accent, size: 18),
                      ]),
                    ),
                  ),
                  
                  // Media preview
                  if (_uploadedMediaUrls.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _uploadedMediaUrls.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final url = _uploadedMediaUrls[index];
                          final isVideo = url.toLowerCase().endsWith('.mp4') ||
                              url.toLowerCase().endsWith('.mov') ||
                              url.toLowerCase().endsWith('.webm');
                          return Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFF1A1A2E),
                                width: 0.8,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  isVideo
                                      ? Container(
                                          color: Colors.black,
                                          child: const Center(
                                            child: Icon(
                                              Icons.play_circle_outline,
                                              color: Colors.white,
                                              size: 40,
                                            ),
                                          ),
                                        )
                                      : Image.network(
                                          '${AuthService().baseUrl}$url',
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            color: Colors.grey[800],
                                            child: const Icon(
                                              Icons.broken_image,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () => _removeMedia(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 28),

                  // Post button
                  GestureDetector(
                    onTap: _uploading ? null : () async {
                      HapticFeedback.mediumImpact();
                      setState(() {});
                      final content = _ctrl.text.trim();
                      if (content.isEmpty && _uploadedMediaUrls.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Write something or add media to post')));
                        return;
                      }
                      // show a small loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => const Center(child: CircularProgressIndicator()),
                      );
                      final auth = AuthService();
                      try {
                        final created = await auth.createPost(content, media: _uploadedMediaUrls);
                        Navigator.pop(context); // close loading
                        if (created != null) {
                          Navigator.pop(context, created);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Posted')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to post')));
                        }
                      } catch (e) {
                        Navigator.pop(context); // close loading
                        final msg = e is Exception ? e.toString().replaceFirst('Exception: ', '') : 'Failed to post';
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to post: $msg')));
                      }
                    },
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [_C.accent, Color(0xFF9B4FE0)]),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _C.accent.withOpacity(0.4),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.send_rounded,
                                color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text('Post Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  SEARCH PROFILE CARD
// ─────────────────────────────────────────────────────────────
class _SearchProfileCard extends StatelessWidget {
  final ProfileData profile;
  const _SearchProfileCard({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [profile.color1, profile.color2],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _C.card,
          borderRadius: BorderRadius.circular(20.5),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(colors: [
                  profile.color1.withOpacity(0.3),
                  profile.color2.withOpacity(0.3),
                ]),
              ),
              child: Icon(profile.icon, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 12),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          profile.name,
                          style: const TextStyle(
                              color: _C.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (profile.isVerified) ...[
                        const SizedBox(width: 4),
                        const Icon(Icons.verified_rounded,
                            size: 13, color: _C.accent),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    profile.role,
                    style:
                        const TextStyle(color: _C.textSec, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 5,
                    runSpacing: 3,
                    children: profile.skills
                        .take(3)
                        .map((s) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: _C.accent.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: _C.accent.withOpacity(0.2),
                                    width: 0.6),
                              ),
                              child: Text(s,
                                  style: const TextStyle(
                                      color: _C.accentSoft,
                                      fontSize: 10)),
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Type badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [profile.color1, profile.color2]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                profile.type,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  HEADER BUTTON
// ─────────────────────────────────────────────────────────────
class _HeaderBtn extends StatelessWidget {
  final IconData icon;
  final int badge;
  final bool active;
  final VoidCallback? onTap;

  const _HeaderBtn(
      {required this.icon,
      this.badge = 0,
      this.active = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(clipBehavior: Clip.none, children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: active ? _C.accent.withOpacity(0.15) : _C.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: active
                    ? _C.accent.withOpacity(0.5)
                    : _C.cardBorder,
                width: 0.8),
          ),
          child: Icon(icon,
              color: active ? _C.accentSoft : _C.textPrimary, size: 18),
        ),
        if (badge > 0)
          Positioned(
            top: -3,
            right: -3,
            child: Container(
              width: 17,
              height: 17,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: _C.rose),
              child: Center(
                  child: Text('$badge',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.w900))),
            ),
          ),
      ]),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  FEATURED CARD  (Flipkart-style full-width banner)
// ─────────────────────────────────────────────────────────────
class _FeaturedCard extends StatelessWidget {
  final _Featured featured;
  final PageController pageController;
  final int pageIndex;

  const _FeaturedCard({
    required this.featured,
    required this.pageController,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (_, child) {
        double value = 0;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - pageIndex;
          value = (1 - (value.abs() * 0.12)).clamp(0.0, 1.0);
        }
        return Transform.scale(
          scale:
              pageController.position.haveDimensions ? value : 1.0,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () => HapticFeedback.lightImpact(),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
                colors: [featured.c1, featured.c2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
            boxShadow: [
              BoxShadow(
                  color: featured.c1.withOpacity(0.4),
                  blurRadius: 24,
                  offset: const Offset(0, 10))
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(children: [
              Positioned(
                  top: -40,
                  right: -40,
                  child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06)))),
              Positioned(
                  bottom: -30,
                  left: -30,
                  child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.04)))),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: _FilmStrip(accent: featured.c1)),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 34, 18, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(featured.badge,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 1)),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.16),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(featured.icon,
                            color: Colors.white, size: 18),
                      ),
                    ]),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(featured.genre,
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 5),
                    Text(featured.title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.6,
                            height: 1.1)),
                    const SizedBox(height: 3),
                    Text(featured.subtitle,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12)),
                    const SizedBox(height: 12),
                    Row(children: [
                      GestureDetector(
                        onTap: () => HapticFeedback.lightImpact(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 9),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(featured.cta,
                              style: TextStyle(
                                  color: featured.c1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 9),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                              width: 0.8),
                        ),
                        child: const Text('Details',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700)),
                      ),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  FILM STRIP (decorative)
// ─────────────────────────────────────────────────────────────
class _FilmStrip extends StatelessWidget {
  final Color accent;
  const _FilmStrip({required this.accent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      color: Colors.black.withOpacity(0.35),
      child: Row(
        children: List.generate(
            24,
            (i) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 1.5, vertical: 5),
                    decoration: BoxDecoration(
                      color: i % 3 == 0
                          ? accent.withOpacity(0.5)
                          : Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  INSTAGRAM-STYLE POST
// ─────────────────────────────────────────────────────────────
class _InstagramPost extends StatefulWidget {
  final _Post post;
  final int index;
  final VoidCallback onLike, onBookmark, onFollow;

  const _InstagramPost({
    super.key,
    required this.post,
    required this.index,
    required this.onLike,
    required this.onBookmark,
    required this.onFollow,
  });

  @override
  State<_InstagramPost> createState() => _InstagramPostState();
}

class _InstagramPostState extends State<_InstagramPost>
    with TickerProviderStateMixin {
  late AnimationController _entryCrl, _heartCtrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _heartScale;
  bool _showHeart = false;

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }

  @override
  void initState() {
    super.initState();
    _entryCrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 480));
    _heartCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _entryCrl, curve: Curves.easeOut);
    _slide =
        Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(
            CurvedAnimation(parent: _entryCrl, curve: Curves.easeOutCubic));
    _heartScale = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.3), weight: 40),
      TweenSequenceItem(
          tween: Tween(begin: 1.3, end: 1.0), weight: 30),
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(
        CurvedAnimation(parent: _heartCtrl, curve: Curves.easeOut));

    Future.delayed(
        Duration(milliseconds: (widget.index % 6) * 80), () {
      if (mounted) _entryCrl.forward();
    });
  }

  @override
  void dispose() {
    _entryCrl.dispose();
    _heartCtrl.dispose();
    super.dispose();
  }

  void _doubleTapLike() {
    if (!widget.post.liked) widget.onLike();
    setState(() => _showHeart = true);
    _heartCtrl.forward(from: 0).then((_) {
      if (mounted) setState(() => _showHeart = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.post;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          decoration: const BoxDecoration(color: _C.card),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Post Header ──────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 8, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(clipBehavior: Clip.none, children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: p.filmmaker
                                ? LinearGradient(
                                    colors: [p.avatarColor, _C.rose],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight)
                                : const LinearGradient(colors: [
                                    _C.cardBorder,
                                    _C.cardBorder
                                  ]),
                          ),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: p.avatarColor,
                              border:
                                  Border.all(color: _C.card, width: 2),
                            ),
                            child: Center(
                                child: Text(p.name[0],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17))),
                          ),
                        ),
                        if (p.verified)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _C.accent,
                                border: Border.all(
                                    color: _C.card, width: 1.5),
                              ),
                              child: const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 9),
                            ),
                          ),
                      ]),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Flexible(
                                child: Text(p.name,
                                    style: const TextStyle(
                                        color: _C.textPrimary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.5),
                                    overflow: TextOverflow.ellipsis),
                              ),
                              if (p.filmmaker) ...[
                                const SizedBox(width: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 1),
                                  decoration: BoxDecoration(
                                    color:
                                        _C.accent.withOpacity(0.15),
                                    borderRadius:
                                        BorderRadius.circular(4),
                                  ),
                                  child: const Text('Filmmaker',
                                      style: TextStyle(
                                          color: _C.accentSoft,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ],
                            ]),
                            Text(
                              p.genre != null
                                  ? '${p.handle}  ·  ${p.genre}'
                                  : '${p.handle}  ·  ${p.ago}',
                              style: const TextStyle(
                                  color: _C.textMuted, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: widget.onFollow,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 220),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: p.following
                                ? null
                                : const LinearGradient(colors: [
                                    _C.accent,
                                    Color(0xFF9B4FE0)
                                  ]),
                            color: p.following ? _C.cardBorder : null,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            p.following ? 'Following' : 'Follow',
                            style: TextStyle(
                                color: p.following
                                    ? _C.textSec
                                    : Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.more_vert_rounded,
                          color: _C.textMuted, size: 20),
                    ],
                  ),
                ),

                if (p.imageLabel != null)
                  GestureDetector(
                    onDoubleTap: _doubleTapLike,
                    child: Stack(alignment: Alignment.center, children: [
                      _PostMedia(
                          label: p.imageLabel!, 
                          accent: p.avatarColor,
                          baseUrl: AuthService().baseUrl),
                      if (_showHeart)
                        ScaleTransition(
                          scale: _heartScale,
                          child: const Icon(Icons.favorite_rounded,
                              color: Colors.white, size: 90),
                        ),
                    ]),
                  ),

                if (p.imageLabel == null)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: p.avatarColor.withOpacity(0.07),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: p.avatarColor.withOpacity(0.15),
                          width: 0.8),
                    ),
                    child: Text(p.body,
                        style: const TextStyle(
                            color: _C.textPrimary,
                            fontSize: 14,
                            height: 1.55)),
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 6, 6, 2),
                  child: Row(children: [
                    _PostAction(
                      icon: p.liked
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: p.liked ? _C.rose : _C.textPrimary,
                      onTap: widget.onLike,
                    ),
                    const SizedBox(width: 2),
                    _PostAction(
                        icon: Icons.chat_bubble_outline_rounded,
                        color: _C.textPrimary,
                        onTap: () {}),
                    const SizedBox(width: 2),
                    _PostAction(
                        icon: Icons.send_outlined,
                        color: _C.textPrimary,
                        onTap: () {}),
                    const Spacer(),
                    _PostAction(
                      icon: p.bookmarked
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: p.bookmarked ? _C.amber : _C.textPrimary,
                      onTap: widget.onBookmark,
                    ),
                  ]),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 2, 14, 4),
                  child: Text('${_fmt(p.likes)} likes',
                      style: const TextStyle(
                          color: _C.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w700)),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 4),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: '${p.name.split(' ').first}  ',
                        style: const TextStyle(
                            color: _C.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 13),
                      ),
                      TextSpan(
                        text: p.body
                            .split('\n')
                            .first
                            .replaceAll(RegExp(r'\s+'), ' '),
                        style: const TextStyle(
                            color: _C.textSec,
                            fontSize: 13,
                            height: 1.4),
                      ),
                    ]),
                  ),
                ),

                if (p.tags.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 4),
                    child: Wrap(
                      spacing: 6,
                      children: p.tags
                          .map((t) => GestureDetector(
                                onTap: () {},
                                child: Text(t,
                                    style: const TextStyle(
                                        color: _C.accentSoft,
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w600)),
                              ))
                          .toList(),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 2),
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                        'View all ${_fmt(p.comments)} comments',
                        style: const TextStyle(
                            color: _C.textMuted, fontSize: 12.5)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 1, 14, 14),
                  child: Text(p.ago,
                      style: const TextStyle(
                          color: _C.textMuted,
                          fontSize: 10.5,
                          letterSpacing: 0.2)),
                ),

                Container(height: 0.5, color: _C.cardBorder),
              ]),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
//  POST MEDIA
// ─────────────────────────────────────────────────────────────
class _PostMedia extends StatefulWidget {
  final String label;
  final Color accent;
  final String baseUrl;
  const _PostMedia({required this.label, required this.accent, required this.baseUrl});

  @override
  State<_PostMedia> createState() => _PostMediaState();
}

class _PostMediaState extends State<_PostMedia>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 160));
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  bool get _isVideo {
    return widget.label.toLowerCase().endsWith('.mp4') ||
        widget.label.toLowerCase().endsWith('.mov') ||
        widget.label.toLowerCase().endsWith('.webm') ||
        widget.label.toLowerCase().endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() => _playing = !_playing);
        _ctrl.forward().then((_) => _ctrl.reverse());
        HapticFeedback.lightImpact();
      },
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: double.infinity,
          height: 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(children: [
              // Media display
              _buildMediaContent(),
              // Overlay gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              // Play button for videos
              if (_isVideo)
                Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    width: _playing ? 56 : 64,
                    height: _playing ? 56 : 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _playing
                          ? widget.accent
                          : widget.accent.withOpacity(0.18),
                      border: Border.all(
                          color: widget.accent.withOpacity(0.55),
                          width: 2),
                      boxShadow: _playing
                          ? [
                              BoxShadow(
                                  color: widget.accent.withOpacity(0.45),
                                  blurRadius: 22)
                            ]
                          : [],
                    ),
                    child: Icon(
                        _playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 32),
                  ),
                ),
              // Media label overlay
              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.label.split('/').last,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildMediaContent() {
    final url = widget.baseUrl + widget.label;
    if (_isVideo) {
      return Container(
        color: Colors.black,
        child: MediaViewer(
          url: widget.label,
          baseUrl: widget.baseUrl,
          isVideo: true,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return MediaViewer(
        url: widget.label,
        baseUrl: widget.baseUrl,
        isVideo: false,
        fit: BoxFit.cover,
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────
//  GRAIN PAINTER
// ─────────────────────────────────────────────────────────────
class _GrainPainter extends CustomPainter {
  final _rng = Random(42);

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..strokeWidth = 0.8;
    for (int i = 0; i < 120; i++) {
      p.color = Colors.white.withOpacity(_rng.nextDouble() * 0.03);
      canvas.drawCircle(
          Offset(_rng.nextDouble() * size.width,
              _rng.nextDouble() * size.height),
          0.7,
          p);
    }
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─────────────────────────────────────────────────────────────
//  POST ACTION BUTTON
// ─────────────────────────────────────────────────────────────
class _PostAction extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _PostAction(
      {required this.icon, required this.color, required this.onTap});

  @override
  State<_PostAction> createState() => _PostActionState();
}

class _PostActionState extends State<_PostAction>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 130));
    _scale = Tween<double>(begin: 1.0, end: 0.65).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _tap() async {
    await _ctrl.forward();
    await _ctrl.reverse();
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _tap,
      child: ScaleTransition(
        scale: _scale,
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Icon(widget.icon, color: widget.color, size: 27),
        ),
      ),
    );
  }
}