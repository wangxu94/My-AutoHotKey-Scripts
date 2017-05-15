;----------------------------------------------------------;
;- MusicBeeIPCSDK AHK v2.0.0                              -;
;- Copyright © Kerli Low 2014                             -;
;- This file is licensed under the                        -;
;- BSD 2-Clause License                                   -;
;- See LICENSE_MusicBeeIPCSDK for more information.       -;
;----------------------------------------------------------;

#include Enums.ahk
#include Constants.ahk


MBIPC_Free(ByRef cds, ByRef data)
{
    VarSetCapacity(cds, 0)
    VarSetCapacity(data, 0)
}

; --------------------------------------------------------------------------------
; All strings are encoded in UTF-16 little endian
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
; -Int32: 32 bit integer
; -Int32: 32 bit integer
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_i(ByRef cds, ByRef data, int32s*)
{
    cb := MBIPC_SIZEOFINT * int32s.SetCapacity(-1)
    
    VarSetCapacity(data, cb, 0)
    
    offset := 0
    
    for key, value in int32s
    {
        NumPut(value, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  Byte count string
; -byte[]: String data
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_s(ByRef cds, ByRef data, strings*)
{
    cb := 0
    
    for key, value in strings
        cb += StrPut(value, "UTF-16") - 1
        
    cb *= MBIPC_SIZEOFWCHAR
    cb += MBIPC_SIZEOFINT * strings.SetCapacity(-1)
    
    VarSetCapacity(data, cb, 0)
    
    offset := 0
    
    for key, value in strings
    {
        len := StrPut(value, "UTF-16") - 1
        byteCount := len * MBIPC_SIZEOFWCHAR
        
        NumPut(byteCount, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT

        StrPut(value, &data + offset, len, "UTF-16")
        offset += byteCount
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  32 bit integer
; -Int32:  32 bit integer
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_si(ByRef cds, ByRef data, ByRef string_1, int32s*)
{
    len := StrPut(string_1, "UTF-16") - 1
    byteCount := len * MBIPC_SIZEOFWCHAR
       
    cb := MBIPC_SIZEOFINT * (int32s.SetCapacity(-1) + 1) + byteCount
    
    VarSetCapacity(data, cb, 0)
 
    NumPut(byteCount, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len, "UTF-16")
    offset += byteCount
 
    for key, value in int32s
    {
        NumPut(value, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  bool
; -Int32:  bool
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_sb(ByRef cds, ByRef data, ByRef string_1, bools*)
{
    len := StrPut(string_1, "UTF-16")
    byteCount := len * MBIPC_SIZEOFWCHAR
       
    cb := MBIPC_SIZEOFINT * (bools.SetCapacity(-1) + 1) + byteCount
    
    VarSetCapacity(data, cb, 0)
 
    NumPut(byteCount, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len, "UTF-16")
    offset += byteCount
 
    for key, value in bools
    {
        NumPut(value, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -double: 64-bit floating-point value
; -double: 64-bit floating-point value
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_sd(ByRef cds, ByRef data, ByRef string_1, doubles*)
{
    len := StrPut(string_1, "UTF-16")
    byteCount := len * MBIPC_SIZEOFWCHAR
       
    cb := MBIPC_SIZEOFINT + byteCount + MBIPC_SIZEOFDOUBLE * doubles.SetCapacity(-1)
    
    VarSetCapacity(data, cb, 0)
 
    NumPut(byteCount, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len, "UTF-16")
    offset += byteCount
 
    for key, value in doubles
    {
        NumPut(value, data, offset, Type="Double")
        offset += MBIPC_SIZEOFDOUBLE
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  Number of strings in string array
; -Int32:  Byte count of string in string array
; -byte[]: String data in string array
; -Int32:  Byte count of string in string array
; -byte[]: String data in string array
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_ssa(ByRef cds, ByRef data, ByRef string_1, ByRef strings)
{
    num := strings.SetCapacity(-1)
    
    len := StrPut(string_1, "UTF-16") - 1
    byteCount := len * MBIPC_SIZEOFWCHAR
       
    cb := len
    
    for key, value in strings
        cb += StrPut(value, "UTF-16") - 1
        
    cb *= MBIPC_SIZEOFWCHAR
    cb += MBIPC_SIZEOFINT * (num + 2)
    
    VarSetCapacity(data, cb, 0)
 
    NumPut(byteCount, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len, "UTF-16")
    offset += byteCount
    
    NumPut(num, data, offset, Type="Int")
    offset += MBIPC_SIZEOFINT
    
    for key, value in strings
    {
        len := StrPut(value, "UTF-16") - 1
        byteCount := len * MBIPC_SIZEOFWCHAR
        
        NumPut(byteCount, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
        
        StrPut(value, &data + offset, len, "UTF-16")
        offset += byteCount
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  Number of strings in string array
; -Int32:  Byte count of string in string array
; -byte[]: String data in string array
; -Int32:  Byte count of string in string array
; -byte[]: String data in string array
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_sssa(ByRef cds, ByRef data, ByRef string_1, ByRef string_2, ByRef strings)
{
    num := strings.SetCapacity(-1)
    
    len_1 := StrPut(string_1, "UTF-16") - 1
    byteCount_1 := len_1 * MBIPC_SIZEOFWCHAR
    
    len_2 := StrPut(string_2, "UTF-16") - 1
    byteCount_2 := len_2 * MBIPC_SIZEOFWCHAR
    
    cb := len_1 + len_2
    
    for key, value in strings
        cb += StrPut(value, "UTF-16") - 1
        
    cb *= MBIPC_SIZEOFWCHAR
    cb += MBIPC_SIZEOFINT * (num + 3)
    
    VarSetCapacity(data, cb, 0)
    
    NumPut(byteCount_1, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len_1, "UTF-16")
    offset += byteCount_1
    
    NumPut(byteCount_2, data, offset, Type="Int")
    offset += MBIPC_SIZEOFINT
    
    StrPut(string_2, &data + offset, len_2, "UTF-16")
    offset += byteCount_2
    
    NumPut(num, data, offset, Type="Int")
    offset += MBIPC_SIZEOFINT
    
    for key, value in strings
    {
        len := StrPut(value, "UTF-16") - 1
        byteCount := len * MBIPC_SIZEOFWCHAR
        
        NumPut(byteCount, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
        
        StrPut(value, &data + offset, len, "UTF-16")
        offset += byteCount
    }
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  32 bit integer
; -Int32:  Byte count of string
; -byte[]: String data
; -...
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_sis(ByRef cds, ByRef data, ByRef string_1, int32_1, ByRef string_2)
{
    len_1 := StrPut(string_1, "UTF-16") - 1
    byteCount_1 := len_1 * MBIPC_SIZEOFWCHAR
    
    len_2 := StrPut(string_2, "UTF-16") - 1
    byteCount_2 := len_2 * MBIPC_SIZEOFWCHAR
    
    cb := MBIPC_SIZEOFINT * 3 + byteCount_1 + byteCount_2
    
    VarSetCapacity(data, cb, 0)
       
    NumPut(byteCount_1, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len_1, "UTF-16")
    offset += byteCount_1
 
    NumPut(int32_1, data, offset, Type="Int")
    offset += MBIPC_SIZEOFINT
       
    NumPut(byteCount, &data + offset, len_2, Type="Int")
    offset += MBIPC_SIZEOFINT
    
    StrPut(string_2, &data + offset, len_2, "UTF-16")
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32: Number of integers in integer array
; -Int32: 32 bit integer
; -Int32: 32 bit integer
; -...
; -Int32: 32 bit integer
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_iai(ByRef cds, ByRef data, ByRef int32s, int32_1)
{
    num := int32s.SetCapacity(-1)
    
    cb := MBIPC_SIZEOFINT * (num + 2)
    
    VarSetCapacity(data, cb, 0)
    
    NumPut(num, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    for key, value in int32s
    {
        NumPut(value, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
    }
    
    NumPut(int32_1, data, offset, Type="Int")
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  Number of integers in integer array
; -Int32:  32 bit integer
; -Int32:  32 bit integer
; -...
; -Int32:  32 bit integer
; Free cds and data after use
; --------------------------------------------------------------------------------
MBIPC_Pack_siai(ByRef cds, ByRef data, ByRef string_1, ByRef int32s, int32_1)
{
    num := int32s.SetCapacity(-1)
 
    len := StrPut(string_1, "UTF-16") - 1
    byteCount := len * MBIPC_SIZEOFWCHAR
    
    cb := MBIPC_SIZEOFINT * (num + 3) + byteCount
    
    VarSetCapacity(data, cb, 0)
    
    NumPut(byteCount, data, 0, Type="Int")
    offset := MBIPC_SIZEOFINT
    
    StrPut(string_1, &data + offset, len, "UTF-16")
    offset += byteCount
    
    NumPut(num, data, offset, Type="Int")
    offset += MBIPC_SIZEOFINT
    
    for key, value in int32s
    {
        NumPut(value, data, offset, Type="Int")
        offset += MBIPC_SIZEOFINT
    }
    
    NumPut(int32_1, data, offset, Type="Int")
    
    MBIPC_GenCDS(cds, 0, cb, &data)
}


MBIPC_GenCDS(ByRef cds, dwData, cbData, lpData)
{
    VarSetCapacity(cds, MBIPC_SIZEOFCDS, 0)
    NumPut(dwData, cds, 0, Type="UInt") ; dwData
    NumPut(cbData, cds, A_PtrSize, Type="UInt") ; cbData
    NumPut(lpData, cds, A_PtrSize * 2, Type="Ptr") ; lpData
    return cds
}
