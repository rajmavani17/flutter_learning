import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/filter_provider.dart';

class FiltersPage extends ConsumerWidget {
  const FiltersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterValues = ref.watch(filterProvider);

    bool glutenFreeFilterSet = filterValues[Filter.glutenFree] ?? false;
    bool lactoseFreeFilterSet = filterValues[Filter.lactoseFree] ?? false;
    bool vegetarianFilterSet = filterValues[Filter.vegeterian] ?? false;
    bool veganFilterSet = filterValues[Filter.vegan] ?? false;

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: glutenFreeFilterSet,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .switchFilterStatus(Filter.glutenFree, isChecked);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            subtitle: Text(
              'Only Include Gluten-Free Meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: lactoseFreeFilterSet,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .switchFilterStatus(Filter.lactoseFree, isChecked);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            subtitle: Text(
              'Only Include Lactose-Free Meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: vegetarianFilterSet,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .switchFilterStatus(Filter.vegeterian, isChecked);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            subtitle: Text(
              'Only Include Vegetarian Meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
          SwitchListTile(
            value: veganFilterSet,
            onChanged: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .switchFilterStatus(Filter.vegan, isChecked);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            subtitle: Text(
              'Only Include Vegan Meals.',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(
              left: 34,
              right: 22,
            ),
          ),
        ],
      ),
    );
  }
}
