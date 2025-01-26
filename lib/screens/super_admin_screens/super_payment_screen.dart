import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/custom_add_button.dart';
import '../../widgets/therapist/record_payment.dart';

class SuperPaymentsScreen extends StatefulWidget {
  const SuperPaymentsScreen({super.key});

  @override
  State<SuperPaymentsScreen> createState() => _SuperPaymentsScreenState();
}

class _SuperPaymentsScreenState extends State<SuperPaymentsScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Center Payment",
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color.fromARGB(255, 24, 8, 41),
          ),
        ),
        actions: [
          CustomAddButton(
            title: "Record Payment",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecordPayment(),
                ),
              );
            },
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
            child: Row(
              children: [
                _buildTab('Upcoming Payments', 0),
                _buildTab('Transaction History', 1),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _selectedTab == 0
                  ? _buildUpcomingPayments()
                  : _buildTransactionHistory(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected
                    ? Color.fromARGB(255, 65, 184, 119)
                    : Color.fromARGB(255, 235, 246, 237),
                width: 3,
              ),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: isSelected
                  ? Color.fromARGB(255, 65, 184, 119)
                  : Color.fromARGB(255, 149, 160, 172),
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingPayments() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 7,
      itemBuilder: (context, index) {
        return _buildPaymentCard();
      },
    );
  }

  Widget _buildTransactionHistory() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return _buildTransactionCard();
      },
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color.fromARGB(255, 235, 246, 237)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Image.network(
              'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/Payments-viliRhegPEHDJiJdMFWpYWLrFqyskU.png',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gardens Galleria Par...',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 8, 12, 62),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Next Payment • ',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color.fromARGB(255, 149, 160, 172),
                      ),
                    ),
                    Text(
                      '24/02/2023',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 255, 49, 49),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard({bool isDebit = false}) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color:
                  isDebit ? const Color(0xFFFFEBEB) : const Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.attach_money,
              color: isDebit
                  ? const Color.fromARGB(255, 255, 43, 43)
                  : const Color.fromARGB(255, 65, 184, 119),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          // Name and date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Gardens Galleria Par",
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 8, 12, 62),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '23-02-2021•11:00 AM',
                  style: GoogleFonts.inter(
                    color: Color.fromARGB(255, 147, 158, 170),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          // Amount and payment method
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isDebit ? "-" : "+"}₹ 100',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: isDebit
                      ? const Color.fromARGB(255, 255, 43, 43)
                      : const Color.fromARGB(255, 65, 184, 119),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Credit Card',
                style: GoogleFonts.inter(
                  color: Color.fromARGB(255, 103, 103, 103),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
