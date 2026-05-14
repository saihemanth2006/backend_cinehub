import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../widgets/collaborate_dialog.dart';
import 'profile_page.dart';
import '../../services/auth_service.dart';

class ProfileDetailsPage extends StatefulWidget {
  final ProfileData profile;
  final bool initialRequested;
  final VoidCallback? onCollaborateRequested;

  const ProfileDetailsPage({
    super.key,
    required this.profile,
    this.initialRequested = false,
    this.onCollaborateRequested,
  });

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  late bool _requested;
  late int _followersCount;

  @override
  void initState() {
    super.initState();
    _requested = widget.initialRequested;
    _followersCount = widget.profile.followers;
  }

  void _showCollabPopup() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.7),
      transitionDuration: const Duration(milliseconds: 350),
      transitionBuilder: (_, a, __, child) => ScaleTransition(
        scale: CurvedAnimation(parent: a, curve: Curves.easeOutBack),
        child: FadeTransition(opacity: a, child: child),
      ),
      pageBuilder: (_, __, ___) => CollaborateDialog(
        onConfirm: () async {
          // try to follow the profile's user via backend
          final auth = AuthService();
          final target = widget.profile.id.isNotEmpty ? widget.profile.id : widget.profile.name;
          bool ok = false;
          try {
            final resp = await auth.follow(target);
            ok = resp == true;
          } catch (e) {
            ok = false;
          }
          if (ok) {
            setState(() {
              _requested = true;
              _followersCount = _followersCount + 1;
            });
            widget.onCollaborateRequested?.call();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xff111111),
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              content: Row(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffFF8C00), Color(0xffFF3D00)]),
                  ),
                  child: const Icon(Icons.check_rounded,
                      size: 13, color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text("Collaboration request sent! 🎬",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ]),
              duration: const Duration(seconds: 3),
            ));
          } else {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: const Color(0xff111111),
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              content: Row(children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                  ),
                  child: const Icon(Icons.error_outline, size: 13, color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Text("Failed to send request",
                    style: TextStyle(fontWeight: FontWeight.w600)),
              ]),
              duration: const Duration(seconds: 3),
            ));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profile;
    return Scaffold(
      backgroundColor: const Color(0xff09090B),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero header ─────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: const Color(0xff09090B),
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded, size: 17),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(fit: StackFit.expand, children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [p.color1, p.color2],
                    ),
                  ),
                ),
                Container(color: Colors.black.withOpacity(0.45)),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 95, left: 24, right: 24),
                  child: Column(children: [
                    Hero(
                      tag: 'profile_${p.name}',
                      child: Container(
                        width: 105,
                        height: 105,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              colors: [p.color1, p.color2]),
                          boxShadow: [
                            BoxShadow(
                                color: p.color1.withOpacity(0.5),
                                blurRadius: 28),
                          ],
                        ),
                        child:
                            Icon(p.icon, size: 50, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(p.name,
                            style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w800)),
                        if (p.isVerified) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.verified_rounded,
                              size: 18, color: Color(0xffFF8C00)),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(p.role,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.75))),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Location chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  size: 15, color: Colors.white70),
                              const SizedBox(width: 5),
                              Text(p.location,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Availability chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: p.availability == "Open"
                                ? const Color(0xff38ef7d).withOpacity(0.15)
                                : const Color(0xffFF8C00).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: p.availability == "Open"
                                  ? const Color(0xff38ef7d).withOpacity(0.4)
                                  : const Color(0xffFF8C00).withOpacity(0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: p.availability == "Open"
                                      ? const Color(0xff38ef7d)
                                      : const Color(0xffFF8C00),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                p.availability,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: p.availability == "Open"
                                      ? const Color(0xff38ef7d)
                                      : const Color(0xffFF8C00),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ]),
            ),
          ),

          // ── Content ─────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                          // Stats row
                            Row(children: [
                              _stat("${p.projects}", "Projects",
                                  Icons.movie_creation, p),
                              const SizedBox(width: 12),
                              _stat("${p.rating}", "Rating", Icons.star_rounded, p),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => FollowersPage())),
                                child: _stat(
                                  _followersCount > 999
                                      ? "${(_followersCount / 1000).toStringAsFixed(1)}K"
                                      : "$_followersCount",
                                  "Followers",
                                  Icons.people_rounded,
                                  p,
                                ),
                              ),
                            ]),

                  const SizedBox(height: 26),

                  // Action buttons
                  Row(children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: _requested ? null : _showCollabPopup,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            gradient: _requested
                                ? LinearGradient(colors: [
                                    Colors.white.withOpacity(0.07),
                                    Colors.white.withOpacity(0.07),
                                  ])
                                : LinearGradient(
                                    colors: [p.color1, p.color2]),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  _requested
                                      ? Icons.check_circle_rounded
                                      : Icons.handshake_rounded,
                                  size: 17,
                                  color: _requested
                                      ? Colors.greenAccent
                                      : Colors.white,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _requested ? "Requested" : "Collaborate",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: _requested
                                        ? Colors.white.withOpacity(0.5)
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    _iconBtn(Icons.chat_bubble_outline),
                    const SizedBox(width: 10),
                    _iconBtn(Icons.share_rounded),
                  ]),

                  const SizedBox(height: 28),

                  // About
                  const Text("About",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 12),
                  Text(
                    p.bio.isNotEmpty
                        ? p.bio
                        : "${p.name} is a talented ${p.role.toLowerCase()} actively working in the film industry.",
                    style: TextStyle(
                        height: 1.7,
                        color: Colors.white.withOpacity(0.72),
                        fontSize: 13.5),
                  ),

                  const SizedBox(height: 28),

                  // Skills
                  const Text("Skills",
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: p.skills
                        .map((s) => Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  p.color1.withOpacity(0.22),
                                  p.color2.withOpacity(0.22),
                                ]),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.06)),
                              ),
                              child: Text(s,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13)),
                            ))
                        .toList(),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stat(
      String v, String l, IconData icon, ProfileData p) =>
      Expanded(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Column(children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [p.color1, p.color2]),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(height: 10),
            Text(v,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 3),
            Text(l,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 11)),
          ]),
        ),
      );

  Widget _iconBtn(IconData icon) => Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon),
      );
}
