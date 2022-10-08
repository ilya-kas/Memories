import 'package:memories/domain/entity/memory.dart';
import 'package:memories/domain/repository/memories_repository.dart';

///loads memories, stored at remote database/storage
class GetStoredMemoriesUseCase {
  final MemoriesRepository _memoriesRepository;

  GetStoredMemoriesUseCase(this._memoriesRepository);

  Future<List<Memory>> call() async {
    return await _memoriesRepository.loadMemories();
  }
}