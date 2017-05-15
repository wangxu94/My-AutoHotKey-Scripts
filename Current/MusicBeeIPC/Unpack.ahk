;----------------------------------------------------------;
;- MusicBeeIPCSDK AHK v2.0.0                              -;
;- Copyright © Kerli Low 2014                             -;
;- This file is licensed under the                        -;
;- BSD 2-Clause License                                   -;
;- See LICENSE_MusicBeeIPCSDK for more information.       -;
;----------------------------------------------------------;

#include Enums.ahk
#include Constants.ahk


; --------------------------------------------------------------------------------
; All strings are encoded in UTF-16 little endian
; --------------------------------------------------------------------------------

; --------------------------------------------------------------------------------
; -Int32:  Byte count of string
; -byte[]: String data
; Free lr after use
; --------------------------------------------------------------------------------
MBIPC_Unpack_s(Byref lr, ByRef string_1)
{
    string_1 := ""
    
    mmf := MBIPC_OpenMmf(lr)
    if !mmf
        return MB_False
        
    view := MBIPC_MapMmfView(mmf, lr, ptr)
    if !view
    {
        MBIPC_CloseMmf(mmf)
        return MB_False
    }
    
    byteCount := NumGet(ptr+0, 0, "Int")
    ptr += MBIPC_SIZEOFINT
        
    if byteCount > 0
        string_1 := StrGet(ptr, byteCount // MBIPC_SIZEOFWCHAR, "UTF-16")
    
    MBIPC_UnmapMmfView(view)
    
    MBIPC_CloseMmf(mmf)
    
    return MB_True
}

; --------------------------------------------------------------------------------
; -Int32:  Number of strings
; -Int32:  Byte count of string
; -byte[]: String data
; -Int32:  Byte count of string
; -byte[]: String data
; -...
; Free lr after use
; --------------------------------------------------------------------------------
MBIPC_Unpack_sa(Byref lr, ByRef strings)
{
    strings := Array()
    
    mmf := MBIPC_OpenMmf(lr)
    if !mmf
        return MB_False
        
    view := MBIPC_MapMmfView(mmf, lr, ptr)
    if !view
    {
        MBIPC_CloseMmf(mmf)
        return MB_False
    }
    
    strCount := NumGet(ptr+0, 0, "Int")
    ptr += MBIPC_SIZEOFINT
    
    strings.SetCapacity(strCount)
    
    Loop % strCount
    {
        byteCount := NumGet(ptr+0, 0, "Int")
        ptr += MBIPC_SIZEOFINT
        
        if byteCount > 0
        {
            strings.Insert(StrGet(ptr, byteCount // MBIPC_SIZEOFWCHAR, "UTF-16"))
            ptr += byteCount
        }
    }
    
    MBIPC_UnmapMmfView(view)
    
    MBIPC_CloseMmf(mmf)
    
    return MB_True
}

; --------------------------------------------------------------------------------
; -Int32: 32 bit integer
; -Int32: 32 bit integer
; Free lr after use
; --------------------------------------------------------------------------------
MBIPC_Unpack_ii(Byref lr, ByRef int32_1, ByRef int32_2)
{
    int32_1 := int32_2 := 0
    
    mmf := MBIPC_OpenMmf(lr)
    if !mmf
        return MB_False
        
    view := MBIPC_MapMmfView(mmf, lr, ptr)
    if !view
    {
        MBIPC_CloseMmf(mmf)
        return MB_False
    }
    
    int32_1 := NumGet(ptr+0, 0, "Int")
    ptr += MBIPC_SIZEOFINT
    
    int32_2 := NumGet(ptr+0, 0, "Int")
    
    MBIPC_UnmapMmfView(view)
    
    MBIPC_CloseMmf(mmf)
    
    return MB_True
}

; --------------------------------------------------------------------------------
; -Int32: Number of integers
; -Int32: 32 bit integer
; -Int32: 32 bit integer
; -...
; Free lr after use
; --------------------------------------------------------------------------------
MBIPC_Unpack_ia(Byref lr, ByRef int32s)
{
    int32s := Array()
    
    mmf := MBIPC_OpenMmf(lr)
    if !mmf
        return MB_False
        
    view := MBIPC_MapMmfView(mmf, lr, ptr)
    if !view
    {
        MBIPC_CloseMmf(mmf)
        return MB_False
    }
    
    int32Count := NumGet(ptr+0, 0, "Int")
    ptr += MBIPC_SIZEOFINT
    
    int32s.SetCapacity(int32Count)
    
    Loop % int32Count
    {
        int32s.Insert(NumGet(ptr+0, 0, "Int"))
        ptr += MBIPC_SIZEOFINT
    }
    
    MBIPC_UnmapMmfView(view)
    
    MBIPC_CloseMmf(mmf)
    
    return MB_True
}


MBIPC_OpenMmf(ByRef lr)
{
    if !lr
        return MB_False

    ; FILE_MAP_READ = 0x0004 = 4
    ; FALSE = 0
    return DllCall("OpenFileMapping", UInt, 4, Int, 0, Str, "mbipc_mmf_" . NumGet(lr, 0, "UShort"), UInt)
}

MBIPC_CloseMmf(mmf)
{
    DllCall("CloseHandle", UInt, mmf)
}

MBIPC_MapMmfView(mmf, ByRef lr, ByRef ptr)
{
    ; FILE_MAP_READ = 0x0004 = 4
    view := DllCall("MapViewOfFile", UInt, mmf, UInt, 4, UInt, 0, UInt, 0, UInt, 0, UInt)
    
    ptr := view + NumGet(lr, MBIPC_SIZEOFSHORT, "UShort") + MBIPC_SIZEOFLONG
    
    return view
}

MBIPC_UnmapMmfView(view)
{
    DllCall("UnmapViewOfFile", UInt, view)
}

MBIPC_GetLResult(el)
{
    if el = FAIL
        return MB_False
        
    VarSetCapacity(lr, MBIPC_SIZEOFINT)
    NumPut(el, lr, 0, "Int")
    return lr
}
