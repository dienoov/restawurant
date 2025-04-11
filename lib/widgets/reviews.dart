import 'package:flutter/material.dart';
import 'package:restawurant/apis/restaurants.dart';
import 'package:restawurant/models/restaurant.dart';

class Reviews extends StatefulWidget {
  final String id;
  final List<CustomerReview> customerReviews;
  final Function() onSubmit;

  const Reviews({
    super.key,
    required this.customerReviews,
    required this.id,
    required this.onSubmit,
  });

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  void onSubmit() async {
    if (!mounted) {
      return;
    }

    if (_nameController.text.isEmpty || _reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.onError,
        ),
      );
      return;
    }

    try {
      final bool result = await RestaurantsApi().review(
        widget.id,
        _nameController.text,
        _reviewController.text,
      );

      if (!mounted) {
        return;
      }

      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Thank you for your review!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
        widget.onSubmit();
        _nameController.clear();
        _reviewController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to submit review',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.onError,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.onError,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w900),
        ),
        const SizedBox.square(dimension: 8),
        ...List.generate(widget.customerReviews.length, (index) {
          final CustomerReview review = widget.customerReviews[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 4),
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              child: Text(
                review.name[0].toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontSize: 16,
                ),
              ),
            ),
            title: Container(
              margin: const EdgeInsets.only(bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(review.name)),
                  Text(
                    review.date,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            subtitle: Text(review.review),
          );
        }),
        const SizedBox.square(dimension: 24),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                width: 1,
              ),
            ),
          ),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
        const SizedBox.square(dimension: 8),
        TextField(
          controller: _reviewController,
          minLines: 5,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: 'Write your review here',
            hintStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
              fontSize: 16,
            ),
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                width: 1,
              ),
            ),
          ),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
        const SizedBox.square(dimension: 8),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            minimumSize: const Size.fromHeight(48),
          ),
          onPressed: onSubmit,
          child: Text(
            'Submit',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
