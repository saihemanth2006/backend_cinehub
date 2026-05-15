import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/collaborate_dialog.dart';
import '../notifications/notifications_page.dart';
import '../profile/profile_details_page.dart';
import 'widgets/category_delegate.dart';

class ProjectsPage extends StatefulWidget {
  final List<ProfileData> allProfiles;
  final Set<int> bookmarked;
  final Set<int> collaborated;
  final void Function(int) onBookmark;
  final void Function(int) onCollaborate;

  const ProjectsPage({
    super.key,
    required this.allProfiles,
    required this.bookmarked,
    required this.collaborated,
    required this.onBookmark,
    required this.onCollaborate,
  });

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  String _category = "All";
  final TextEditingController _searchCtrl = TextEditingController();
  String _query = "";
  bool _searchExpanded = true;
  final ScrollController _scrollCtrl = ScrollController();
  static const double _threshold = 60.0;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(() {
      final scrolled = _scrollCtrl.offset > _threshold;
      if (scrolled && _searchExpanded) setState(() => _searchExpanded = false);
      if (!scrolled && !_searchExpanded) setState(() => _searchExpanded = true);
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  // ── Filtered profile list ──────────────────────────────────────────────
  List<ProfileData> get _filtered =>
      widget.allProfiles.asMap().entries.where((e) {
        final p = e.value;
        final catOk = _category == "All" ||
            (_category == "Saved" && widget.bookmarked.contains(e.key)) ||
            p.type == _category;
        final q = _query.toLowerCase();
        final qOk =
            q.isEmpty || p.name.toLowerCase().contains(q) || p.role.toLowerCase().contains(q);
        return catOk && qOk;
      }).map((e) => e.value).toList();

  // ── Collaboration popup ────────────────────────────────────────────────
  void _showCollabPopup(int index) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 350),
      transitionBuilder: (_, anim, __, child) => ScaleTransition(
        scale: CurvedAnimation(parent: anim, curve: Curves.easeOutBack),
        child: FadeTransition(opacity: anim, child: child),
      ),
      pageBuilder: (_, __, ___) => CollaborateDialog(
        onConfirm: () {
          widget.onCollaborate(index);
          Navigator.pop(context);
          _snack("Collaboration request sent! 🎬");
        },
      ),
    );
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: const Color(0xff111111),
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Row(children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: [Color(0xffFF8C00), Color(0xffFF3D00)]),
          ),
          child: const Icon(Icons.check_rounded, size: 13, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text(msg, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      ]),
      duration: const Duration(seconds: 3),
    ));
  }

  // ── Build ──────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final profiles = _filtered;
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xff09090B),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              child: Row(
                children: [
                  _glass(Icons.menu_rounded),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "Projects",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const NotificationsPage()),
                    ),
                    child: Stack(children: [
                      _glass(Icons.notifications_none_rounded),
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xffFF8C00), Color(0xffFF3D00)],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),

            // Scrollable area + floating search
            Expanded(
              child: Stack(
                children: [
                  CustomScrollView(
                    controller: _scrollCtrl,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      const SliverToBoxAdapter(child: SizedBox(height: 68)),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: CategoryDelegate(
                          selected: _category,
                          onChange: (c) => setState(() => _category = c),
                        ),
                      ),
                      profiles.isEmpty
                          ? SliverFillRemaining(
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.search_off_rounded,
                                        size: 52,
                                        color: Colors.white.withOpacity(0.15)),
                                    const SizedBox(height: 12),
                                    Text(
                                      _category == "Saved"
                                          ? "No saved profiles yet"
                                          : "No results found",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white.withOpacity(0.3),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SliverPadding(
                              padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
                              sliver: SliverList(
                                delegate: SliverChildBuilderDelegate(
                                  (_, i) {
                                    final p = profiles[i];
                                    final globalIdx = widget.allProfiles.indexOf(p);
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 14),
                                      child: _profileCard(p, globalIdx),
                                    );
                                  },
                                  childCount: profiles.length,
                                ),
                              ),
                            ),
                    ],
                  ),

                  // Floating search bar
                  Positioned(
  top: 8,
  right: 20,
  child: AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.fastOutSlowIn,
    width: _searchExpanded ? sw - 40 : 52,
    height: 52,
    decoration: BoxDecoration(
      color: const Color(0xff151515),
      borderRadius:
          BorderRadius.circular(_searchExpanded ? 20 : 26),
      border: Border.all(
        color: Colors.white.withOpacity(0.06),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.4),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    clipBehavior: Clip.hardEdge,
    child: AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: _searchExpanded
          ? _expandedSearch()
          : _collapsedSearch(),
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

  Widget _expandedSearch() => ClipRect(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0),
          child: Row(
            children: [
              const SizedBox(width: 14),

              Icon(
                Icons.search_rounded,
                color: Colors.white.withOpacity(0.6),
                size: 20,
              ),

              const SizedBox(width: 8),

              SizedBox(
                width: 180,
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search cast & crew...",
                    hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.3),
                      fontSize: 13,
                    ),
                  ),
                ),
              ),

              if (_query.isNotEmpty)
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: Colors.white.withOpacity(0.4),
                    size: 18,
                  ),
                  onPressed: () {
                    _searchCtrl.clear();
                    setState(() => _query = "");
                  },
                ),

              IconButton(
                icon: Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white.withOpacity(0.4),
                ),
                onPressed: () =>
                    setState(() => _searchExpanded = false),
              ),
            ],
          ),
        ),
      ),
    );

  Widget _collapsedSearch() => GestureDetector(
        onTap: () => setState(() => _searchExpanded = true),
        child: Center(
          child: Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.7)),
        ),
      );

  // ── Profile card ───────────────────────────────────────────────────────
  Widget _profileCard(ProfileData profile, int index) {
    final bool saved = widget.bookmarked.contains(index);
    final bool requested = widget.collaborated.contains(index);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProfileDetailsPage(
            profile: profile,
            initialRequested: requested,
            onCollaborateRequested: () {
              if (!requested) widget.onCollaborate(index);
            },
          ),
        ),
      ),
      child: Hero(
        tag: 'profile_${profile.name}',
        child: Container(
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
              color: const Color(0xff111111),
              borderRadius: BorderRadius.circular(20.5),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: LinearGradient(colors: [
                      profile.color1.withOpacity(0.25),
                      profile.color2.withOpacity(0.25),
                    ]),
                  ),
                  child: Icon(profile.icon, color: Colors.white),
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
                                  fontSize: 14, fontWeight: FontWeight.w700),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (profile.isVerified) ...[
                            const SizedBox(width: 4),
                            const Icon(Icons.verified_rounded,
                                size: 13, color: Color(0xffFF8C00)),
                          ],
                        ],
                      ),
                      Text(
                        profile.role,
                        style: TextStyle(
                            fontSize: 11, color: Colors.white.withOpacity(0.55)),
                      ),
                      const SizedBox(height: 6),
                      Wrap(
                        spacing: 5,
                        runSpacing: 3,
                        children: profile.skills
                            .map((s) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.07),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    s,
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.65)),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),

                // Right column — bookmark + collab
                SizedBox(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => widget.onBookmark(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: saved
                                ? Colors.orange.withOpacity(0.2)
                                : Colors.white.withOpacity(0.06),
                          ),
                          child: Icon(
                            saved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 16,
                            color: saved
                                ? const Color(0xffFF8C00)
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: requested ? null : () => _showCollabPopup(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 80,
                          height: 34,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: requested
                                ? LinearGradient(colors: [
                                    Colors.white.withOpacity(0.07),
                                    Colors.white.withOpacity(0.07),
                                  ])
                                : LinearGradient(
                                    colors: [profile.color1, profile.color2]),
                          ),
                          child: Center(
                            child: Text(
                              requested ? "Requested" : "Collab",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: requested
                                    ? Colors.white.withOpacity(0.45)
                                    : Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _glass(IconData icon) => Container(
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.white.withOpacity(0.06),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      );
}
