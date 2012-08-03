
from espresso cimport *
from utils cimport *


cdef extern from "stdlib.h":
	void free(void* ptr)
	void* malloc(size_t size)
	void* realloc(void* ptr, size_t size)
			      

cdef extern from "../src/utils.h":
	ctypedef struct IntList:
		int *e
		int n
	cdef void init_intlist(IntList *il)
	cdef void alloc_intlist(IntList *il, int size)
	cdef void realloc_intlist(IntList *il, int size)

cdef extern from "../src/utils.h":
	ctypedef struct DoubleList:
		int *e
		int n
	cdef void init_intlist(IntList *il)
	cdef void alloc_intlist(IntList *il, int size)
	cdef void realloc_intlist(IntList *il, int size)

cdef IntList* create_IntList_from_python_object(obj)