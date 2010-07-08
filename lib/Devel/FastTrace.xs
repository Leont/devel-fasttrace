#define PERL_NO_GET_CONTEXT
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

SV* S_stack_info(pTHX_ IV skip) {
	AV* ret = newAV();
	I32 index = cxstack_ix;
	HV* rowstash = gv_stashpv("Devel::FastTrace::Row", GV_ADD);
	if (skip > 0)
		index -= skip;
	for (; index > 0; index--) {
		const PERL_CONTEXT* cx = cxstack + index;
		AV* row = newAV();
		av_push(row, newSVpv(CopSTASHPV(cx->blk_oldcop), 0));
		if (CxTYPE(cx) == CXt_SUB || CxTYPE(cx) == CXt_FORMAT) {
			GV * const cvgv = CvGV(cx->blk_sub.cv);
			if (isGV(cvgv)) {
				SV * const name = newSV(0);
				gv_efullname3(name, cvgv, NULL);
				av_push(row, name);
			}
			else {
				av_push(row, newSVpvn("(unknown)", 9));
			}
		}
		else if (CxTYPE(cx) == CXt_EVAL) {
				av_push(row, newSVpvn("(eval)", 6));
		}
		else {
			SvREFCNT_dec((SV*)row);
			continue;
		}
		av_push(row, newSVpv(OutCopFILE(cxstack[index].blk_oldcop), 0));
		av_push(row, newSViv(CopLINE(cxstack[index].blk_oldcop)));

		av_push(ret, sv_bless(newRV_noinc((SV*)row), rowstash));
	}
	HV* retstash = gv_stashpv("Devel::FastTrace::Info", 0);
	return sv_bless(newRV_noinc((SV*)ret), retstash);
}
#define stack_info(skip) S_stack_info(aTHX_ skip)

MAGIC* S_get_magic(pTHX_ SV* error) {
	MAGIC* magic;
	if (!SvROK(error) || SV_TYPE(SvRV(error)) != SVt_PVAV || !RMAGICAL(SvRV(error)) || (magic = mg_find(SvRV(error), PERL_MAGIC_ext)))
		Perl_die(aTHX_ "Invalid exception");
	return magic;
}
#define get_magic(error) S_get_magic(aTHX_ error)

MODULE = Devel::FastTrace  PACKAGE = Devel::FastTrace

SV*
stack_info(skip = 0)
	IV skip;

void
succumb(message)
	SV* message;
	CODE:
		if (SvROK(message)) {
			SV* errsv = get_sv("@", GV_ADD);
			SV* oldvalue = newSVsv(errsv);
			sv_magic(SvRV(message), stack_info(0), PERL_MAGIC_ext, (char*)oldvalue, HEf_SVKEY);
			SvREFCNT_dec(oldvalue);
			SvSetSV(errsv, message);
			Perl_die(aTHX_ NULL);
		}
		else 
			Perl_die(aTHX_ "%s", SvPV_nolen(message));

void
all_trace(error)
	SV* error;
	PREINIT:
		MAGIC* magic;
		int i;
	PPCODE:
		magic = get_magic(error);
		AV* traces = (AV*)SvRV(magic->mg_obj);
		for (i = 0; i <= av_len(traces); i++)
			XPUSH(*av_fetch(traces, i, FALSE));

SV*
previous_error(error)
	SV* error;
	PREINIT:
		MAGIC* magic;
	CODE:
		RETVAL = (SV*)magic->mg_ptr;
	OUTPUT:
		RETVAL
