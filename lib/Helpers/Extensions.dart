extension FormatString on Duration {
  String get mmSSFormat {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes =
        twoDigits(this.inMinutes.remainder(Duration.minutesPerHour));
    String twoDigitSeconds =
        twoDigits(this.inSeconds.remainder(Duration.secondsPerMinute));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

extension ExtractMusicName on String {
  String get songName {
    final List<String> nameSplited =
        this.split("/").last.split(".").first.split("-");
    return "${nameSplited.first.capitalize} ${nameSplited.last.capitalize}";
  }

  String get capitalize {
    return this[0].toUpperCase() + this.substring(1);
  }
}
