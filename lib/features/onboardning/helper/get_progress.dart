double getProgressForPage(int currentPage) {
  switch (currentPage) {
    case 0:
      return 0.0;
    case 1:
      return 0.3;
    case 2:
      return 0.6;
    case 3:
      return 1.0;
    default:
      return 0.0;
  }
}
