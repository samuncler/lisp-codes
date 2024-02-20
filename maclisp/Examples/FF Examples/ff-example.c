/*                                                                          *//*                                                                          *//* FF-example.c                                                             *//* Copyright 1988-1994 Apple Computer, Inc.                                 *//* Copyright 1995 Digitool, Inc.                                            *//*                                                                          *//*                                                                          *//*  Examples of the Macintosh Common Lisp Foreign Function Interface,       *//*  C component.                                                            *//* Change History04/01/96 bill  Update for MCL-PPC data representation*/#include <ctype.h>#include <memory.h>plus_one (i)  int i;  {    return i+1;  }digitval (ch)  char ch;{  if isdigit(ch) return ch - '0';  else return -1;}setchar (str, idx, ch)  char *str;  int idx;  char ch;{  str[idx] = ch;}flt_incr (x, incr)  double *x;  double incr;{  *x += incr;}double add_flt (x, y)	double x,y;	{	   return x + y;	}#define FIXNUM_SHIFT 2  /* Lisp fixnums are stored in upper 30 bits */#define CDR(x) (* ((long *) (((long) x) - 1)))#define CAR(x) (* ((Ptr *) (((long) x) + 3)))#define v_data (-2)#define MACPTR_PTR(x) (* ((Ptr *) (((long) (x)) + v_data)))growptr (consptr)  long *consptr;{  Ptr newp;  if (MACPTR_PTR(CAR(*consptr))) DisposPtr(MACPTR_PTR(CAR(*consptr)));  newp = NewPtr((CDR(*consptr)) >> FIXNUM_SHIFT);  MACPTR_PTR(CAR(*consptr)) = newp;}int addthree (i, lispfn)	int i, (*lispfn) ();	{	i = i + 1;	i = (*lispfn) (i);	return i + 1;	}