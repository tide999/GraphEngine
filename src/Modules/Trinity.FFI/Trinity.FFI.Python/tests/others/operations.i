

%module operations
%include <stdint.i>
%{
#include "swig_accessor.h"
#include "CellAccessor.h"
#define SWIG_FILE_WITH_INIT
static void (* _Set_Cell_C2(void*, void*) = (void (*)(void*, void*))0x177e8070200ll;static void Set_Cell_C2(void* subject, void* object){       return _Set_Cell_C2(subject, object);}
static void* (* _Get_Cell_C2)(void*) = (void* (*)(void*))0x177e80701c0ll;static void* Get_Cell_C2(void *subject){       return _GetCell_C2(subject);}
static void (* _Cell_C2_Set_bar)(void*, char*) = (void (*)(void*, char*))0x177e8070180ll;static void Cell_C2_Set_bar(void* subject, char* object){    return _Cell_C2_Set_bar(subject, object);}
static char* (* _Cell_C2_Get_bar)(void*) = (char* (*)(void*))0x177e8070140ll;static char* Cell_C2_Get_bar(void* subject){    return _Cell_C2_Get_bar(subject);}
static void (* _Set_Cell_C2(void*, void*) = (void (*)(void*, void*))0x177e80700c0ll;static void Set_Cell_C2(void* subject, void* object){       return _Set_Cell_C2(subject, object);}
static void* (* _Get_Cell_C2)(void*) = (void* (*)(void*))0x177e8070080ll;static void* Get_Cell_C2(void *subject){       return _GetCell_C2(subject);}
static void (* _Cell_C2_Set_lst)(void*, void*) = (void (*)(void*, void*))0x177e8070040ll;static void Cell_C2_Set_lst(void* subject, void* object){    return _Cell_C2_Set_lst(subject, object);}
static void* (* _Cell_C2_Get_lst)(void*) = (void* (*)(void*))0x177e8070000ll;static void* Cell_C2_Get_lst(void* subject){    return _Cell_C2_Get_lst(subject);}

CellAccessor* Use_Cell_C2(int64_t cellid, int32_t options)
{
    CellAccessor* accessor = new CellAccessor();
    accessor->cellId = cellid;
    auto errCode = LockCell(*accessor, options);
    if (errCode)
    throw errCode;
    return accessor;
}
                               
static int (* _Count_List_int32)(void*) = (int (*)(void* )) 0x177e8070340ll;static int Count_List_int32(void* subject){    return _Count_List_int32(subject);}
static bool (* _Contains_List_int32)(void*, int32_t) = (bool (*)(void*, int32_t)) 0x177e8070300ll;static bool Contains_List_int32(void* subject, int32_t object){    return _Contains_List_int32(subject, object);}
static void (* _List_int32_Set)(void*, int,  int32_t) = (void (*)(void*, int, int32_t object))0x177e80702c0ll;static void List_int32_Set(void* subject, int idx, int32_t object){return _List_int32_Set(subject, idx, object);}
static int32_t (* _List_int32_Get)(void*, int) =  (int32_t (*)(void*, int))0x177e8070280ll;static int32_t List_int32_Get(void* subject, int idx){        return _List_int32_Get(subject, idx);}
static void (* _Set_Cell_C1(void*, void*) = (void (*)(void*, void*))0x177e8070580ll;static void Set_Cell_C1(void* subject, void* object){       return _Set_Cell_C1(subject, object);}
static void* (* _Get_Cell_C1)(void*) = (void* (*)(void*))0x177e8070540ll;static void* Get_Cell_C1(void *subject){       return _GetCell_C1(subject);}
static void (* _Cell_C1_Set_bar)(void*, char*) = (void (*)(void*, char*))0x177e8070500ll;static void Cell_C1_Set_bar(void* subject, char* object){    return _Cell_C1_Set_bar(subject, object);}
static char* (* _Cell_C1_Get_bar)(void*) = (char* (*)(void*))0x177e80704c0ll;static char* Cell_C1_Get_bar(void* subject){    return _Cell_C1_Get_bar(subject);}
static void (* _Set_Cell_C1(void*, void*) = (void (*)(void*, void*))0x177e8070440ll;static void Set_Cell_C1(void* subject, void* object){       return _Set_Cell_C1(subject, object);}
static void* (* _Get_Cell_C1)(void*) = (void* (*)(void*))0x177e8070400ll;static void* Get_Cell_C1(void *subject){       return _GetCell_C1(subject);}
static void (* _Cell_C1_Set_foo)(void*, int32_t) = (void (*)(void*, int32_t))0x177e80703c0ll;static void Cell_C1_Set_foo(void* subject, int32_t object){    return _Cell_C1_Set_foo(subject, object);}
static int32_t (* _Cell_C1_Get_foo)(void*) = (int32_t (*)(void*))0x177e8070380ll;static int32_t Cell_C1_Get_foo(void* subject){    return _Cell_C1_Get_foo(subject);}

CellAccessor* Use_Cell_C1(int64_t cellid, int32_t options)
{
    CellAccessor* accessor = new CellAccessor();
    accessor->cellId = cellid;
    auto errCode = LockCell(*accessor, options);
    if (errCode)
    throw errCode;
    return accessor;
}
                               
%}
static void Set_Cell_C2(void*, void*);
static void* Get_Cell_C2(void *);
static void Cell_C2_Set_bar(void*, char*);
static char* Cell_C2_Get_bar(void*);
static void Set_Cell_C2(void*, void*);
static void* Get_Cell_C2(void *);
static void Cell_C2_Set_lst(void*, void*);
static void* Cell_C2_Get_lst(void*);
CellAccessor* Use_Cell_C2(int64_t cellid, int32_t options);
static int Count_List_int32(void* subject);
static bool Contains_List_int32(void*, int32_t);
static void List_int32_Set(void*, int, int32_t);
static int32_t List_int32_Get(void*, int);
static void Set_Cell_C1(void*, void*);
static void* Get_Cell_C1(void *);
static void Cell_C1_Set_bar(void*, char*);
static char* Cell_C1_Get_bar(void*);
static void Set_Cell_C1(void*, void*);
static void* Get_Cell_C1(void *);
static void Cell_C1_Set_foo(void*, int32_t);
static int32_t Cell_C1_Get_foo(void*);
CellAccessor* Use_Cell_C1(int64_t cellid, int32_t options);
%newobject Use_Cell_C2;
%newobject Use_Cell_C1;
            