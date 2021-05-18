from atsconan import ATSConan

class ATSConan(ATSConan):
    name = "ats-result"
    version = "0.1.1"
    settings = "os", "compiler", "build_type", "arch"
    exports_sources = "*"