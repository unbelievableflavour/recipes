project('com.github.bartzaalberg.recipes', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

# add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

# Set this for convenience
conf = configuration_data()

# Get the package data directory under Meson
pkgdatadir = join_paths([ get_option('prefix'),
                          get_option('datadir')])

conf.set_quoted('PKGDATADIR', pkgdatadir)

# Other configs
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
conf
add_global_arguments('-DDATADIR="' + get_option('datadir') + '"', language: 'c')
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

# Arguments for C
c_args = [
  '-include', 'config.h',
  '-w'
]

cc = meson.get_compiler('c')

# Find libMarkdown
libmarkdown = dependency('libmarkdown', version: '>= 2.2.1', required: false)
if libmarkdown.found() == false
    cc = meson.get_compiler('c')
    libmarkdown = cc.find_library('libmarkdown', required: true)
endif

asresources = gnome.compile_resources(
    'as-resources', 'data/icons/icons.gresource.xml',
    source_dir: 'data/icons',
    c_name: 'as'
)

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/Recipe.vala',
    'src/MainWindow.vala',
    'src/PhotoCard.vala',
    'src/PhotosFlowBox.vala',
    'src/RecipeFileManager.vala',
    'src/Constants.vala',
    'src/StackManager.vala',
    'src/Dialogs/Alert.vala',
    'src/Services/FileHandler.vala',
    'src/Services/PDFExporter.vala',
    'src/Services/IconHandler.vala',
    'src/Views/WebView.vala',
    'src/Views/ListView.vala',
    'src/Views/ProgressView.vala',
    'src/Components/HeaderBar.vala',
    asresources,
    c_args: c_args,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('granite'),
        dependency('webkit2gtk-4.0'),
        dependency('json-glib-1.0'),
        dependency('libsoup-2.4'),
        libmarkdown,
    ],
    vala_args: [
        meson.source_root() + '/vapi/config.vapi',
        #meson.source_root() + '/vapi/libmarkdown.vapi',
        '--vapidir=' + meson.source_root() + '/vapi/',
    ],
    install: true
)

subdir('data')
subdir('po')

install_data(
    join_paths('data', meson.project_name() + '.desktop'),
    install_dir: join_paths(get_option('datadir'), 'applications')
)

install_data(
    join_paths('data', meson.project_name() + '.appdata.xml'),
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

python3 = import('python3').find_python()
run_command(python3, '-c', 'import shutil; shutil.copy("hooks/pre-commit.hook", ".git/hooks/pre-commit")')
