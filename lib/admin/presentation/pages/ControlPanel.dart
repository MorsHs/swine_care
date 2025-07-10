import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swine_care/colors/ArgieColors.dart';
import 'package:swine_care/colors/ArgieSizes.dart';
import 'package:swine_care/data/model/AdminSettings.dart';
import 'package:swine_care/data/repositories/AdminSettingsService.dart';

class ControlPanel extends StatefulWidget {
  const ControlPanel({super.key});

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  final AdminSettingsService _service = AdminSettingsService();
  AdminSettings? _settings;
  bool _loading = true;
  bool _saving = false;
  String? _error;

  // Controllers
  final _highRiskThreshold = TextEditingController();
  final _mediumRiskThreshold = TextEditingController();
  final _lowRiskThreshold = TextEditingController();
  final _highRiskLabel = TextEditingController();
  final _mediumRiskLabel = TextEditingController();
  final _lowRiskLabel = TextEditingController();
  final _earsWeight = TextEditingController();
  final _skinWeight = TextEditingController();
  final _symptomsWeight = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final settings = await _service.getCurrentSettings();
      _settings = settings;
      _highRiskThreshold.text = settings.highRiskThreshold.toString();
      _mediumRiskThreshold.text = settings.mediumRiskThreshold.toString();
      _lowRiskThreshold.text = settings.lowRiskThreshold.toString();
      _highRiskLabel.text = settings.highRiskLabel;
      _mediumRiskLabel.text = settings.mediumRiskLabel;
      _lowRiskLabel.text = settings.lowRiskLabel;
      _earsWeight.text = settings.earsWeight.toString();
      _skinWeight.text = settings.skinWeight.toString();
      _symptomsWeight.text = settings.symptomsWeight.toString();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load settings: $e';
        _loading = false;
      });
    }
  }

  Future<void> _saveSettings() async {
    setState(() => _saving = true);
    try {
      await _service.updateSettings(
        highRiskThreshold: double.tryParse(_highRiskThreshold.text),
        mediumRiskThreshold: double.tryParse(_mediumRiskThreshold.text),
        lowRiskThreshold: double.tryParse(_lowRiskThreshold.text),
        highRiskLabel: _highRiskLabel.text.trim(),
        mediumRiskLabel: _mediumRiskLabel.text.trim(),
        lowRiskLabel: _lowRiskLabel.text.trim(),
        earsWeight: double.tryParse(_earsWeight.text),
        skinWeight: double.tryParse(_skinWeight.text),
        symptomsWeight: double.tryParse(_symptomsWeight.text),
      );
      await _loadSettings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Settings saved!', style: GoogleFonts.poppins())),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save: $e', style: GoogleFonts.poppins())),
        );
      }
    } finally {
      setState(() => _saving = false);
    }
  }

  Future<void> _resetDefaults() async {
    setState(() => _saving = true);
    try {
      await _service.updateSettings(
        highRiskThreshold: 80.0,
        mediumRiskThreshold: 30.0,
        lowRiskThreshold: 0.0,
        highRiskLabel: "High Risk",
        mediumRiskLabel: "Medium Risk",
        lowRiskLabel: "Low Risk",
        earsWeight: 30.0,
        skinWeight: 30.0,
        symptomsWeight: 40.0,
      );
      await _loadSettings();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reset to defaults!', style: GoogleFonts.poppins())),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to reset: $e', style: GoogleFonts.poppins())),
        );
      }
    } finally {
      setState(() => _saving = false);
    }
  }

  double get _totalWeight {
    final e = double.tryParse(_earsWeight.text) ?? 0;
    final s = double.tryParse(_skinWeight.text) ?? 0;
    final sy = double.tryParse(_symptomsWeight.text) ?? 0;
    return e + s + sy;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Control Panel', style: GoogleFonts.poppins()),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        foregroundColor: isDark ? Colors.white : Colors.black,
        elevation: 1,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: GoogleFonts.poppins(color: Colors.red)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Risk Thresholds', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _numberField('High', _highRiskThreshold)),
                          const SizedBox(width: 8),
                          Expanded(child: _numberField('Medium', _mediumRiskThreshold)),
                          const SizedBox(width: 8),
                          Expanded(child: _numberField('Low', _lowRiskThreshold)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Risk Labels', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _textField('High', _highRiskLabel)),
                          const SizedBox(width: 8),
                          Expanded(child: _textField('Medium', _mediumRiskLabel)),
                          const SizedBox(width: 8),
                          Expanded(child: _textField('Low', _lowRiskLabel)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text('Weights (%)', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _numberField('Ears', _earsWeight)),
                          const SizedBox(width: 8),
                          Expanded(child: _numberField('Skin', _skinWeight)),
                          const SizedBox(width: 8),
                          Expanded(child: _numberField('Symptoms', _symptomsWeight)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text('Total: ${_totalWeight.toStringAsFixed(1)}%',
                              style: GoogleFonts.poppins(
                                color: (_totalWeight - 100).abs() < 0.1 ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              )),
                          if ((_totalWeight - 100).abs() >= 0.1)
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Weights must total 100%', style: GoogleFonts.poppins(color: Colors.red)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _saving || (_totalWeight - 100).abs() >= 0.1 ? null : _saveSettings,
                              child: _saving
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                    )
                                  : Text('Save', style: GoogleFonts.poppins(  color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _saving ? null : _resetDefaults,
                              child: Text('Reset to Defaults', style: GoogleFonts.poppins(
                                        color: Colors.black45
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => context.go('/login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ArgieColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: ArgieSizes.paddingDefault,
                              vertical: ArgieSizes.spaceBtwItems,
                            ),
                          ),
                          child: Text(
                            "Back to Login",
                            style: GoogleFonts.poppins(
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _numberField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      style: GoogleFonts.poppins(),
    );
  }

  Widget _textField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
      ),
      style: GoogleFonts.poppins(),
    );
  }
}
