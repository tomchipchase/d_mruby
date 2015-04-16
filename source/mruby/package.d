module mruby;

import mruby.value;
import mruby.proc;
import mruby.mrb_class;
import mruby.object;
import mruby.variable;
import mruby.gc;

import core.stdc.config;

extern (C):

alias uint mrb_code;
alias uint mrb_aspec;
alias void* function (mrb_state*, void*, c_ulong, void*) mrb_allocf;
alias _Anonymous_0 mrb_callinfo;
alias void function (mrb_state*) mrb_atexit_func;
alias mrb_value function (mrb_state*, mrb_value) mrb_func_t;

struct alloca_header;
struct kh_n2s;
struct symbol_name;

enum mrb_fiber_state
{
	MRB_FIBER_CREATED = 0,
	MRB_FIBER_RUNNING = 1,
	MRB_FIBER_RESUMING = 2,
	MRB_FIBER_SUSPENDED = 3,
	MRB_FIBER_TRANSFERRED = 4,
	MRB_FIBER_TERMINATED = 5
}

enum GC_state
{
	GC_STATE_ROOT = 0,
	GC_STATE_MARK = 1,
	GC_STATE_SWEEP = 2
}

enum call_type
{
	CALL_PUBLIC = 0,
	CALL_FCALL = 1,
	CALL_VCALL = 2,
	CALL_TYPE_MAX = 3
}

struct _Anonymous_0
{
	mrb_sym mid;
	RProc* proc;
	mrb_value* stackent;
	int nregs;
	int ridx;
	int eidx;
	REnv* env;
	mrb_code* pc;
	mrb_code* err;
	int argc;
	int acc;
	RClass* target_class;
}

struct mrb_context
{
	mrb_context* prev;
	mrb_value* stack;
	mrb_value* stbase;
	mrb_value* stend;
	mrb_callinfo* ci;
	mrb_callinfo* cibase;
	mrb_callinfo* ciend;
	mrb_code** rescue;
	int rsize;
	RProc** ensure;
	int esize;
	enum mrb_fiber_state
	{
		MRB_FIBER_CREATED = 0,
		MRB_FIBER_RUNNING = 1,
		MRB_FIBER_RESUMING = 2,
		MRB_FIBER_SUSPENDED = 3,
		MRB_FIBER_TRANSFERRED = 4,
		MRB_FIBER_TERMINATED = 5
	}
	mrb_fiber_state status;
	RFiber* fib;
}

struct mrb_state
{
	mrb_jmpbuf* jmp;
	mrb_allocf allocf;
	void* allocf_ud;
	mrb_context* c;
	mrb_context* root_c;
	RObject* exc;
	iv_tbl* globals;
	RObject* top_self;
	RClass* object_class;
	RClass* class_class;
	RClass* module_class;
	RClass* proc_class;
	RClass* string_class;
	RClass* array_class;
	RClass* hash_class;
	RClass* float_class;
	RClass* fixnum_class;
	RClass* true_class;
	RClass* false_class;
	RClass* nil_class;
	RClass* symbol_class;
	RClass* kernel_module;
	heap_page* heaps;
	heap_page* sweeps;
	heap_page* free_heaps;
	size_t live;
	RBasic** arena;
	int arena_capa;
	int arena_idx;
	GC_state gc_state;
	int current_white_part;
	RBasic* gray_list;
	RBasic* atomic_gray_list;
	size_t gc_live_after_mark;
	size_t gc_threshold;
	int gc_interval_ratio;
	int gc_step_ratio;
	mrb_bool gc_disabled;
	mrb_bool gc_full;
	mrb_bool is_generational_gc_mode;
	mrb_bool out_of_memory;
	size_t majorgc_old_threshold;
	alloca_header* mems;
	mrb_sym symidx;
	kh_n2s* name2sym;
	symbol_name* symtbl;
	size_t symcapa;
	RClass* eException_class;
	RClass* eStandardError_class;
	RObject* nomem_err;
	void* ud;
	mrb_atexit_func* atexit_stack;
	mrb_int atexit_stack_len;
}

struct mrb_jmpbuf;


struct mrb_irep;


struct mrb_pool;


RClass* mrb_define_class (mrb_state*, const(char)*, RClass*);
RClass* mrb_define_module (mrb_state*, const(char)*);
mrb_value mrb_singleton_class (mrb_state*, mrb_value);
void mrb_include_module (mrb_state*, RClass*, RClass*);
void mrb_define_method (mrb_state*, RClass*, const(char)*, mrb_func_t, mrb_aspec);
void mrb_define_class_method (mrb_state*, RClass*, const(char)*, mrb_func_t, mrb_aspec);
void mrb_define_singleton_method (mrb_state*, RObject*, const(char)*, mrb_func_t, mrb_aspec);
void mrb_define_module_function (mrb_state*, RClass*, const(char)*, mrb_func_t, mrb_aspec);
void mrb_define_const (mrb_state*, RClass*, const(char)* name, mrb_value);
void mrb_undef_method (mrb_state*, RClass*, const(char)*);
void mrb_undef_class_method (mrb_state*, RClass*, const(char)*);
mrb_value mrb_obj_new (mrb_state* mrb, RClass* c, mrb_int argc, const(mrb_value)* argv);
mrb_value mrb_instance_new (mrb_state* mrb, mrb_value cv);
RClass* mrb_class_new (mrb_state* mrb, RClass* super_);
RClass* mrb_module_new (mrb_state* mrb);
mrb_bool mrb_class_defined (mrb_state* mrb, const(char)* name);
RClass* mrb_class_get (mrb_state* mrb, const(char)* name);
RClass* mrb_class_get_under (mrb_state* mrb, RClass* outer, const(char)* name);
RClass* mrb_module_get (mrb_state* mrb, const(char)* name);
RClass* mrb_module_get_under (mrb_state* mrb, RClass* outer, const(char)* name);
mrb_value mrb_notimplement_m (mrb_state*, mrb_value);
mrb_value mrb_obj_dup (mrb_state* mrb, mrb_value obj);
mrb_value mrb_check_to_integer (mrb_state* mrb, mrb_value val, const(char)* method);
mrb_bool mrb_obj_respond_to (mrb_state* mrb, RClass* c, mrb_sym mid);
RClass* mrb_define_class_under (mrb_state* mrb, RClass* outer, const(char)* name, RClass* super_);
RClass* mrb_define_module_under (mrb_state* mrb, RClass* outer, const(char)* name);

mrb_aspec MRB_ARGS_NONE()
{
	return cast(mrb_aspec)0;
}

mrb_int mrb_get_args (mrb_state* mrb, const(char)* format, ...);
mrb_value mrb_funcall (mrb_state*, mrb_value, const(char)*, mrb_int, ...);
mrb_value mrb_funcall_argv (mrb_state*, mrb_value, mrb_sym, mrb_int, const(mrb_value)*);
mrb_value mrb_funcall_with_block (mrb_state*, mrb_value, mrb_sym, mrb_int, const(mrb_value)*, mrb_value);
mrb_sym mrb_intern_cstr (mrb_state*, const(char)*);
mrb_sym mrb_intern (mrb_state*, const(char)*, size_t);
mrb_sym mrb_intern_static (mrb_state*, const(char)*, size_t);
mrb_sym mrb_intern_str (mrb_state*, mrb_value);
mrb_value mrb_check_intern_cstr (mrb_state*, const(char)*);
mrb_value mrb_check_intern (mrb_state*, const(char)*, size_t);
mrb_value mrb_check_intern_str (mrb_state*, mrb_value);
const(char)* mrb_sym2name (mrb_state*, mrb_sym);
const(char)* mrb_sym2name_len (mrb_state*, mrb_sym, mrb_int*);
mrb_value mrb_sym2str (mrb_state*, mrb_sym);
void* mrb_malloc (mrb_state*, size_t);
void* mrb_calloc (mrb_state*, size_t, size_t);
void* mrb_realloc (mrb_state*, void*, size_t);
void* mrb_realloc_simple (mrb_state*, void*, size_t);
void* mrb_malloc_simple (mrb_state*, size_t);
RBasic* mrb_obj_alloc (mrb_state*, mrb_vtype, RClass*);
void mrb_free (mrb_state*, void*);
mrb_value mrb_str_new (mrb_state* mrb, const(char)* p, size_t len);
mrb_value mrb_str_new_cstr (mrb_state*, const(char)*);
mrb_value mrb_str_new_static (mrb_state* mrb, const(char)* p, size_t len);
mrb_state* mrb_open ();
mrb_state* mrb_open_allocf (mrb_allocf, void* ud);
mrb_state* mrb_open_core (mrb_allocf, void* ud);
void mrb_close (mrb_state*);
void* mrb_default_allocf (mrb_state*, void*, size_t, void*);
mrb_value mrb_top_self (mrb_state*);
mrb_value mrb_run (mrb_state*, RProc*, mrb_value);
mrb_value mrb_toplevel_run (mrb_state*, RProc*);
mrb_value mrb_context_run (mrb_state*, RProc*, mrb_value, uint);
void mrb_p (mrb_state*, mrb_value);
mrb_int mrb_obj_id (mrb_value obj);
mrb_sym mrb_obj_to_sym (mrb_state* mrb, mrb_value name);
mrb_bool mrb_obj_eq (mrb_state*, mrb_value, mrb_value);
mrb_bool mrb_obj_equal (mrb_state*, mrb_value, mrb_value);
mrb_bool mrb_equal (mrb_state* mrb, mrb_value obj1, mrb_value obj2);
mrb_value mrb_convert_to_integer (mrb_state* mrb, mrb_value val, int base);
mrb_value mrb_Integer (mrb_state* mrb, mrb_value val);
mrb_value mrb_Float (mrb_state* mrb, mrb_value val);
mrb_value mrb_inspect (mrb_state* mrb, mrb_value obj);
mrb_bool mrb_eql (mrb_state* mrb, mrb_value obj1, mrb_value obj2);
void mrb_garbage_collect (mrb_state*);
void mrb_full_gc (mrb_state*);
void mrb_incremental_gc (mrb_state*);
int mrb_gc_arena_save (mrb_state*);
void mrb_gc_arena_restore (mrb_state*, int);
void mrb_gc_mark (mrb_state*, RBasic*);
void mrb_field_write_barrier (mrb_state*, RBasic*, RBasic*);
void mrb_write_barrier (mrb_state*, RBasic*);
mrb_value mrb_check_convert_type (mrb_state* mrb, mrb_value val, mrb_vtype type, const(char)* tname, const(char)* method);
mrb_value mrb_any_to_s (mrb_state* mrb, mrb_value obj);
const(char)* mrb_obj_classname (mrb_state* mrb, mrb_value obj);
RClass* mrb_obj_class (mrb_state* mrb, mrb_value obj);
mrb_value mrb_class_path (mrb_state* mrb, RClass* c);
mrb_value mrb_convert_type (mrb_state* mrb, mrb_value val, mrb_vtype type, const(char)* tname, const(char)* method);
mrb_bool mrb_obj_is_kind_of (mrb_state* mrb, mrb_value obj, RClass* c);
mrb_value mrb_obj_inspect (mrb_state* mrb, mrb_value self);
mrb_value mrb_obj_clone (mrb_state* mrb, mrb_value self);
mrb_value mrb_exc_new (mrb_state* mrb, RClass* c, const(char)* ptr, c_long len);
void mrb_exc_raise (mrb_state* mrb, mrb_value exc);
void mrb_raise (mrb_state* mrb, RClass* c, const(char)* msg);
void mrb_raisef (mrb_state* mrb, RClass* c, const(char)* fmt, ...);
void mrb_name_error (mrb_state* mrb, mrb_sym id, const(char)* fmt, ...);
void mrb_warn (mrb_state* mrb, const(char)* fmt, ...);
void mrb_bug (mrb_state* mrb, const(char)* fmt, ...);
void mrb_print_backtrace (mrb_state* mrb);
void mrb_print_error (mrb_state* mrb);
mrb_value mrb_yield (mrb_state* mrb, mrb_value b, mrb_value arg);
mrb_value mrb_yield_argv (mrb_state* mrb, mrb_value b, mrb_int argc, const(mrb_value)* argv);
mrb_value mrb_yield_with_class (mrb_state* mrb, mrb_value b, mrb_int argc, const(mrb_value)* argv, mrb_value self, RClass* c);
void mrb_gc_protect (mrb_state* mrb, mrb_value obj);
mrb_value mrb_to_int (mrb_state* mrb, mrb_value val);
void mrb_check_type (mrb_state* mrb, mrb_value x, mrb_vtype t);
void mrb_define_alias (mrb_state* mrb, RClass* klass, const(char)* name1, const(char)* name2);
const(char)* mrb_class_name (mrb_state* mrb, RClass* klass);
void mrb_define_global_const (mrb_state* mrb, const(char)* name, mrb_value val);
mrb_value mrb_attr_get (mrb_state* mrb, mrb_value obj, mrb_sym id);
mrb_bool mrb_respond_to (mrb_state* mrb, mrb_value obj, mrb_sym mid);
mrb_bool mrb_obj_is_instance_of (mrb_state* mrb, mrb_value obj, RClass* c);
mrb_value mrb_fiber_resume (mrb_state* mrb, mrb_value fib, mrb_int argc, const(mrb_value)* argv);
mrb_value mrb_fiber_yield (mrb_state* mrb, mrb_int argc, const(mrb_value)* argv);
mrb_pool* mrb_pool_open (mrb_state*);
void mrb_pool_close (mrb_pool*);
void* mrb_pool_alloc (mrb_pool*, size_t);
void* mrb_pool_realloc (mrb_pool*, void*, size_t oldlen, size_t newlen);
mrb_bool mrb_pool_can_realloc (mrb_pool*, void*, size_t);
void* mrb_alloca (mrb_state* mrb, size_t);
void mrb_state_atexit (mrb_state* mrb, mrb_atexit_func func);
void mrb_show_version (mrb_state* mrb);
void mrb_show_copyright (mrb_state* mrb);
mrb_value mrb_format (mrb_state* mrb, const(char)* format, ...);
