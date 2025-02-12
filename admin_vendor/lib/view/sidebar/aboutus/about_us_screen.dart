import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lottie Animation
              Center(
                child: Lottie.asset(
                  'assets/animation/dot.json', // Add your work in progress animation
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),

              // Company Name
              Text(
                'Prakrut Systems',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Description
              Text(
                'We are passionate about creating innovative solutions that empower businesses to thrive in the digital age.',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 30),

              // What We Do Section
              Text(
                'What We Do',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              _buildFeatureItem(
                title: 'Software Development',
                description: 'Custom solutions tailored to your needs',
                icon: Icons.computer,
              ),
              _buildFeatureItem(
                title: 'Mobile Applications',
                description: 'Cross-platform apps for modern businesses',
                icon: Icons.mobile_friendly,
              ),
              _buildFeatureItem(
                title: 'Web Solutions',
                description: 'Responsive and scalable web applications',
                icon: Icons.web,
              ),

              const SizedBox(height: 30),

              // Contact Info
              Text(
                'Get in Touch',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              _buildContactItem(
                icon: Icons.email,
                text: 'contact@prakrutsystems.com',
              ),
              _buildContactItem(
                icon: Icons.phone,
                text: '+91 XXXXXXXXXX',
              ),
              _buildContactItem(
                icon: Icons.location_on,
                text: 'Pune, Maharashtra, India',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 20),
          const SizedBox(width: 15),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
