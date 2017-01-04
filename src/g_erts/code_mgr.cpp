#include "g_platform/debug.h"
#include "g_platform/fs.h"

#include "g_erts/vm.h"
#include "g_erts/code_mgr.h"

namespace gluon {

void CodeManager::load_file(VM &vm, const char *fn) {
    UniqueBox<Uint8> data = File::read_file(fn);
    auto m = std::make_shared<Module>(vm);
    m->load(data.view());
    vm.modules_.add(m);
}

} // ns g_erts