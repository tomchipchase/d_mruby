module mruby.dump;

import mruby.value;
import mruby;
import mruby.compile;

import core.stdc.stdio;

extern (C):

struct rite_binary_header
{
	ubyte[4] binary_ident;
	ubyte[4] binary_version;
	ubyte[2] binary_crc;
	ubyte[4] binary_size;
	ubyte[4] compiler_name;
	ubyte[4] compiler_version;
}

struct rite_section_header
{
	ubyte[4] section_ident;
	ubyte[4] section_size;
}

struct rite_section_irep_header
{
	ubyte[4] section_ident;
	ubyte[4] section_size;
	ubyte[4] rite_version;
}

struct rite_section_lineno_header
{
	ubyte[4] section_ident;
	ubyte[4] section_size;
}

struct rite_section_debug_header
{
	ubyte[4] section_ident;
	ubyte[4] section_size;
}

struct rite_section_lv_header
{
	ubyte[4] section_ident;
	ubyte[4] section_size;
}

struct rite_binary_footer
{
	ubyte[4] section_ident;
	ubyte[4] section_size;
}

int mrb_dump_irep (mrb_state* mrb, mrb_irep* irep, ubyte flags, ubyte** bin, size_t* bin_size);
int mrb_dump_irep_binary (mrb_state*, mrb_irep*, ubyte, FILE*);
int mrb_dump_irep_cfunc (mrb_state* mrb, mrb_irep*, ubyte flags, FILE* f, const(char)* initname);
mrb_irep* mrb_read_irep_file (mrb_state*, FILE*);
mrb_value mrb_load_irep_file (mrb_state*, FILE*);
mrb_value mrb_load_irep_file_cxt (mrb_state*, FILE*, mrbc_context*);
mrb_irep* mrb_read_irep (mrb_state*, const(ubyte)*);
// int bigendian_p (...);
size_t uint8_to_bin (ubyte s, ubyte* bin);
size_t uint16_to_bin (ushort s, ubyte* bin);
size_t uint32_to_bin (uint l, ubyte* bin);
size_t uint32l_to_bin (uint l, ubyte* bin);
uint bin_to_uint32 (const(ubyte)* bin);
uint bin_to_uint32l (const(ubyte)* bin);
ushort bin_to_uint16 (const(ubyte)* bin);
ubyte bin_to_uint8 (const(ubyte)* bin);
ushort calc_crc_16_ccitt (const(ubyte)* src, size_t nbytes, ushort crc);
