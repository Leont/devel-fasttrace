#define PERL_NO_GET_CONTEXT
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

SV*
S_longmess(pTHX_ SV* message) {
	I32 index;
	SV* retval = Perl_newSVpvf(aTHX_ "%s at %s line %d\n", SvPV_nolen(message), OutCopFILE(cxstack[cxstack_ix].blk_oldcop), CopLINE(cxstack[cxstack_ix].blk_oldcop));
	for (index = cxstack_ix - 1; index > 0; index--) {
		const PERL_CONTEXT* cx = cxstack + index;
		if (CxTYPE(cx) == CXt_SUB || CxTYPE(cx) == CXt_FORMAT) {
			GV * const cvgv = CvGV(cx->blk_sub.cv);
			if (isGV(cvgv)) {
				SV * const name = newSV(0);
				gv_efullname3(name, cvgv, NULL);
				Perl_sv_catpvf(aTHX_ retval, "\t%s()", SvPV_nolen(name));
				SvREFCNT_dec(name);
			}
			else {
				sv_catpvn(retval, "\t(unknown)", 10);
			}
		}
		else if (CxTYPE(cx) == CXt_EVAL) {
				sv_catpvn(retval, "\t(eval)", 10);
		}
		else
			continue;
		Perl_sv_catpvf(aTHX_ retval, " called at %s line %d\n", OutCopFILE(cx->blk_oldcop), CopLINE(cx->blk_oldcop));
	}
	return retval;
}
#define longmess(message) S_longmess(aTHX_ message)

SV* S_shortmess(pTHX_ SV* message) {
	const char* current = CopSTASHPV(cxstack[cxstack_ix].blk_oldcop);
	I32 index;
	for (index = cxstack_ix - 1; index > 0; index--) {
		if (CopSTASHPV(cxstack[index].blk_oldcop) != current) {
			return newSVpvf("%s at %s line %d\n", SvPV_nolen(message), OutCopFILE(cxstack[index].blk_oldcop), CopLINE(cxstack[index].blk_oldcop));
		}
	}
	if (index == 0)
		return longmess(message);
}
#define shortmess(message) S_shortmess(aTHX_ message)

MODULE = Devel::FastTrace  PACKAGE = Devel::FastTrace

SV*
shortmess(message)
	SV* message;

SV*
longmess(message)
	SV* message;
