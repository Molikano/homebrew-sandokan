class Sandokan < Formula
  desc "High-performance neural network and deep learning library for C++"
  homepage "https://github.com/Molikano/Sandokan"
  url "https://github.com/Molikano/Sandokan/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "de9190279b8e3f6b7f0ec3a975922d440f2060c021f3f6b2740cdcf9cbcd6305"
  license "MIT"
  head "https://github.com/Molikano/Sandokan.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on :macos

  def install
    system "cmake", "-S", ".", "-B", "build",
      "-DSANDOKAN_BUILD_EXAMPLES=OFF",
      *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <sandokan.h>
      int main() { return 0; }
    CPP
    system ENV.cxx, "-std=c++17", "test.cpp",
      "-I#{include}",
      "-L#{lib}", "-lpmad",
      "-framework", "Accelerate",
      "-o", "test"
  end
end
