 String capitalize(string) {
  if(string == null ||string ==""){return "";}
    return "${string[0].toUpperCase()}${string.substring(1)}";
  }