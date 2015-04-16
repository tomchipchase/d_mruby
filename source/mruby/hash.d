module mruby.hash;

import mruby.mrb_class;
import mruby.object;
import mruby.variable;
import mruby.value;
import mruby;

extern (C):

struct kh_ht;

struct RHash
{
	enum mrb_vtype
	{
		MRB_TT_FALSE = 0,
		MRB_TT_FREE = 1,
		MRB_TT_TRUE = 2,
		MRB_TT_FIXNUM = 3,
		MRB_TT_SYMBOL = 4,
		MRB_TT_UNDEF = 5,
		MRB_TT_FLOAT = 6,
		MRB_TT_CPTR = 7,
		MRB_TT_OBJECT = 8,
		MRB_TT_CLASS = 9,
		MRB_TT_MODULE = 10,
		MRB_TT_ICLASS = 11,
		MRB_TT_SCLASS = 12,
		MRB_TT_PROC = 13,
		MRB_TT_ARRAY = 14,
		MRB_TT_HASH = 15,
		MRB_TT_STRING = 16,
		MRB_TT_RANGE = 17,
		MRB_TT_EXCEPTION = 18,
		MRB_TT_FILE = 19,
		MRB_TT_ENV = 20,
		MRB_TT_DATA = 21,
		MRB_TT_FIBER = 22,
		MRB_TT_MAXDEFINE = 23
	}
	mrb_vtype tt;
	uint color;
	uint flags;
	RClass* c;
	RBasic* gcnext;
	iv_tbl* iv;
	kh_ht* ht;
}

mrb_value mrb_hash_new_capa (mrb_state*, int);
mrb_value mrb_hash_new (mrb_state* mrb);
void mrb_hash_set (mrb_state* mrb, mrb_value hash, mrb_value key, mrb_value val);
mrb_value mrb_hash_get (mrb_state* mrb, mrb_value hash, mrb_value key);
mrb_value mrb_hash_fetch (mrb_state* mrb, mrb_value hash, mrb_value key, mrb_value def);
mrb_value mrb_hash_delete_key (mrb_state* mrb, mrb_value hash, mrb_value key);
mrb_value mrb_hash_keys (mrb_state* mrb, mrb_value hash);
mrb_value mrb_check_hash_type (mrb_state* mrb, mrb_value hash);
mrb_value mrb_hash_empty_p (mrb_state* mrb, mrb_value self);
mrb_value mrb_hash_clear (mrb_state* mrb, mrb_value hash);
kh_ht* mrb_hash_tbl (mrb_state* mrb, mrb_value hash);
void mrb_gc_mark_hash (mrb_state*, RHash*);
size_t mrb_gc_mark_hash_size (mrb_state*, RHash*);
void mrb_gc_free_hash (mrb_state*, RHash*);
