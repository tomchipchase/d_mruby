module mruby.gc;

import mruby;
import mruby.object;

extern (C):

// alias <unimplemented> mrb_each_object_callback;

void mrb_objspace_each_objects (mrb_state* mrb, void function (mrb_state*, RBasic*, void*) callback, void* data);
void mrb_free_context (mrb_state* mrb, mrb_context* c);

struct heap_page;
