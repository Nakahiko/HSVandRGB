class Rect {
  public int left;
  public int top;

  public int right;
  public int bottom;

  Rect(int left_t, int top_t, int right_t, int bottom_t) {
    left = left_t;
    top = top_t;
    right = right_t;
    bottom = bottom_t;
  }

  public int getWidth() {
    return right - left;
  }

  public int getHeight() {
    return bottom - top;
  }
}