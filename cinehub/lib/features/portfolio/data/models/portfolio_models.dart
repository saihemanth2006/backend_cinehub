import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio_models.freezed.dart';
part 'portfolio_models.g.dart';

@freezed
class PortfolioItemDto with _$PortfolioItemDto {
  const factory PortfolioItemDto({
    required String id,
    required String title,
    required String type,
    String? description,
    PortfolioMediaDto? media,
    List<String>? tags,
    List<PortfolioCreditDto>? credits,
    int? viewCount,
    int? likeCount,
    bool? isFeatured,
    String? visibility,
    String? owner,
    DateTime? createdAt,
  }) = _PortfolioItemDto;

  factory PortfolioItemDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioItemDtoFromJson(json);
}

@freezed
class PortfolioMediaDto with _$PortfolioMediaDto {
  const factory PortfolioMediaDto({
    required String url,
    String? thumbnail,
    String? type,
    int? duration,
    String? resolution,
  }) = _PortfolioMediaDto;

  factory PortfolioMediaDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioMediaDtoFromJson(json);
}

@freezed
class PortfolioCreditDto with _$PortfolioCreditDto {
  const factory PortfolioCreditDto({
    String? name,
    String? role,
    String? user,
  }) = _PortfolioCreditDto;

  factory PortfolioCreditDto.fromJson(Map<String, dynamic> json) =>
      _$PortfolioCreditDtoFromJson(json);
}

@freezed
class CreatePortfolioRequest with _$CreatePortfolioRequest {
  const factory CreatePortfolioRequest({
    required String title,
    required String type,
    String? description,
    required PortfolioMediaDto media,
    List<String>? tags,
    String? visibility,
  }) = _CreatePortfolioRequest;

  factory CreatePortfolioRequest.fromJson(Map<String, dynamic> json) =>
      _$CreatePortfolioRequestFromJson(json);
}
