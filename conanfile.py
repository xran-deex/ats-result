from conans import ConanFile, AutoToolsBuildEnvironment
from conans import tools
import os

class ATSConan(ConanFile):
    name = "ats-result"
    version = "0.1.1"
    settings = "os", "compiler", "build_type", "arch"
    generators = "make"
    exports_sources = "*"

    def build(self):
        atools = AutoToolsBuildEnvironment(self)
        atools.make()

    def package(self):
        self.copy("*.hats", dst="", src="")
        self.copy("*.dats", dst="", src="")
        self.copy("*.sats", dst="", src="")

    def package_info(self):
        self.cpp_info.libs = []
