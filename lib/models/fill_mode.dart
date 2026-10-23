enum FillMode {
  normal('Normal'),
  candidate('Candidate');
  
  final String _text;
  
  const FillMode(this._text);
  
  @override
  String toString() => _text;

  FillMode get other {
    switch (this) {
      case FillMode.normal:
        return FillMode.candidate;
      case FillMode.candidate:
        return FillMode.normal;
    }
  }
}
