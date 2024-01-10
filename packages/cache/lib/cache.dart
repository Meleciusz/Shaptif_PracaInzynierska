//Class is used to store cache(temporary data) data and to read it and write it by key.

class CacheClient{
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  //Method that writes the provided [key], [data] pair to the memory cache.
  void writeToMemoryCache<T extends Object>({required String key, required T data}){
    _cache[key] = data;
  }

  //Method that reads the data from the memory cache by the provided key.
  T? readFromMemoryCache<T extends Object>({required String key}){
    final value = _cache[key];

    if(value is T) {
      return value;
    } else {
      return null;
    }
  }
}




