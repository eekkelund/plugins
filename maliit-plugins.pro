include(config.pri)

!isEmpty(HELP) {
    # Output help
    help_string = \
        Important build options: \
        \\n\\t \
        \\nRecognised CONFIG flags: \
        \\n\\t enable-legacy: Build for legacy mode (using meego-im ABI/API compatabible maliit-framework) \
        \\nInfluential environment variables: \
        \\n\\t PKG_CONFIG_PATH: Specify the pkg-config files to use for dependencies \
        \\nExamples: \
        \\n\\t qmake \
        \\n\\t qmake CONFIG+=enable-legacy \

    !build_pass:system(echo -e \"$$help_string\")
} else {
    config_string = Tip: Run qmake HELP=1 for a list of all supported build options

    !build_pass:system(echo -e \"$$config_string\")
}

CONFIG += ordered 
TEMPLATE = subdirs
SUBDIRS = \
    nemo-keyboard \
    maliit-keyboard \

DIST_NAME = $$MALIIT_PACKAGENAME-$$MALIIT_VERSION
DIST_PATH = $$OUT_PWD/$$DIST_NAME
TARBALL_SUFFIX = .tar.bz2
TARBALL_PATH = $$DIST_PATH$$TARBALL_SUFFIX

# The 'make dist' target
# Creates a tarball
QMAKE_EXTRA_TARGETS += dist
dist.target = dist
dist.commands += git archive HEAD --prefix=$$DIST_NAME/ | bzip2 > $$TARBALL_PATH;
dist.commands += md5sum $$TARBALL_PATH | cut -d \' \' -f 1 > $$DIST_PATH\\.md5
