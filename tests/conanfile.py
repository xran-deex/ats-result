from conans import ConanFile, AutoToolsBuildEnvironment
from conans import tools
import os

class ATSConan(ConanFile):
    name = "ats-result-tests"
    version = "0.1.1"
    settings = "os", "compiler", "build_type", "arch"
    generators = "virtualrunenv"
    exports_sources = "*"
    options = {"shared": [True, False], "fPIC": [True, False]}
    default_options = {"shared": False, "fPIC": True}
    requires = "ats-result/0.1.1@randy.valis/testing"
    build_requires = "ats-unit-testing/0.1@randy.valis/testing"

    def build(self):
        atools = AutoToolsBuildEnvironment(self)
        var = atools.vars
        var['ATSFLAGS'] = "-IATS" + " -IATS ".join([ f"{self.deps_cpp_info[x].build_paths[0]}src" for x in self.deps_cpp_info.deps ])
        atools.make(vars=var)

    def package(self):
        self.copy("tests", dst="target", keep_path=False)

    def deploy(self):
        self.copy("*", src="target", dst="bin")
