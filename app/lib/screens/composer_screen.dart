import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/composer_provider.dart';
import '../widgets/create_post/action_ribbon.dart';
import '../widgets/create_post/accessory_row.dart';
import '../widgets/create_post/char_counter.dart';
import '../widgets/create_post/url_preview.dart';

class ComposerScreen extends ConsumerStatefulWidget {
  const ComposerScreen({super.key});

  @override
  ConsumerState<ComposerScreen> createState() => _ComposerScreenState();
}

class _ComposerScreenState extends ConsumerState<ComposerScreen> {
  late final TextEditingController _textController;
  late final FocusNode _focusNode;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _focusNode = FocusNode();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final content = ref.read(composerProvider).content;
      if (content.isNotEmpty) {
        _textController.text = content;
        _textController.selection = TextSelection.collapsed(offset: content.length);
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _handlePost() async {
    try {
      await ref.read(composerProvider.notifier).post();
      if (mounted) {
        HapticFeedback.heavyImpact();
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Failed to post. Try again.'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Compose'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final canPost = ref.watch(composerProvider.select((s) => s.canPost));
              return TextButton(
                onPressed: canPost ? _handlePost : null,
                style: TextButton.styleFrom(
                  foregroundColor: scheme.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // URL Preview (if link detected)
          const UrlPreview(),
          
          // Composer Field + Character Counter
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)
              .copyWith(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildComposerField(),
                  const SizedBox(height: 12),
                  const CharCounter(),
                  const AccessoryRow(),
                ],
              ),
            ),
          ),
          
          // Action Ribbon
          const ActionRibbon(),
        ],
      ),
    );
  }

  Widget _buildComposerField() {
    return Consumer(
      builder: (context, ref, _) {
        final state = ref.watch(composerProvider);
        
        return TextField(
          controller: _textController,
          focusNode: _focusNode,
          maxLines: null,
          maxLength: 1000,
          onChanged: (value) {
            ref.read(composerProvider.notifier).updateContent(value);
          },
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: state.placeholderText,
            hintStyle: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.6),
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            counterText: '',
          ),
        );
      },
    );
  }
}
