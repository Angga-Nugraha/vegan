part of 'components_helper.dart';

Widget listTileShimmer() {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 2,
    child: ListTile(
      minLeadingWidth: 100,
      leading: _shimmerBuilder(width: 150),
      title: _shimmerBuilder(width: 350, height: 20),
      subtitle: Column(
        children: [
          const SizedBox(height: 5),
          _shimmerBuilder(width: 350, height: 10),
          const SizedBox(height: 5),
          _shimmerBuilder(width: 350, height: 10),
        ],
      ),
    ),
  );
}

Widget listShimmer() {
  return SizedBox(
    height: 150,
    width: double.infinity,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _shimmerBuilder(width: 100, height: 150),
        _shimmerBuilder(width: 100, height: 150),
        _shimmerBuilder(width: 100, height: 150),
      ],
    ),
  );
}

Widget gridViewShimmer({bool isVertical = false}) {
  return SizedBox(
    height: isVertical ? 800 : 400,
    child: GridView.builder(
        scrollDirection: isVertical ? Axis.vertical : Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Expanded(
                  flex: 7, child: _shimmerBuilder(height: 150, width: 100)),
              const SizedBox(height: 5),
              Flexible(child: _shimmerBuilder(height: 10, width: 100)),
              const SizedBox(height: 5),
              Flexible(child: _shimmerBuilder(height: 10, width: 100)),
            ],
          );
        }),
  );
}

Widget _shimmerBuilder({double? height, double? width}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.shade300,
    highlightColor: Colors.grey.shade100,
    enabled: true,
    child: Container(
      height: height,
      width: width,
      decoration: ShapeDecoration(
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}
