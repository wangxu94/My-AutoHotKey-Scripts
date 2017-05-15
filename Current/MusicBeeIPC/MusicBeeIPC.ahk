;----------------------------------------------------------;
;- MusicBeeIPCSDK AHK v2.0.0                              -;
;- Copyright © Kerli Low 2014                             -;
;- This file is licensed under the                        -;
;- BSD 2-Clause License                                   -;
;- See LICENSE_MusicBeeIPCSDK for more information.       -;
;----------------------------------------------------------;

#include Enums.ahk
#include Constants.ahk
#include Pack.ahk
#include Unpack.ahk


DetectHiddenWindows, On


; Returns true if MusicBee responded, false otherwise
MB_Probe()
{
    SendMessage, WM_USER, MBC_Probe, 0,, MusicBee IPC Interface
    return ErrorLevel <> MBE_Error
}

; Returns MBError
MB_PlayPause()
{
    SendMessage, WM_USER, MBC_PlayPause, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Play()
{
    SendMessage, WM_USER, MBC_Play, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Pause()
{
    SendMessage, WM_USER, MBC_Pause, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Stop()
{
    SendMessage, WM_USER, MBC_Stop, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_StopAfterCurrent()
{
    SendMessage, WM_USER, MBC_StopAfterCurrent, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_PreviousTrack()
{
    SendMessage, WM_USER, MBC_PreviousTrack, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_NextTrack()
{
    SendMessage, WM_USER, MBC_NextTrack, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_StartAutoDj()
{
    SendMessage, WM_USER, MBC_StartAutoDj, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_EndAutoDj()
{
    SendMessage, WM_USER, MBC_EndAutoDj, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBPlayState
MB_GetPlayState()
{
    SendMessage, WM_USER, MBC_GetPlayState, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns string
MB_GetPlayStateStr()
{
    SendMessage, WM_USER, MBC_GetPlayState, 0,, MusicBee IPC Interface
    if ErrorLevel = %MBPS_Loading%
        return "Loading"
    else if ErrorLevel = %MBPS_Playing%
        return "Playing"
    else if ErrorLevel = %MBPS_Paused%
        return "Paused"
    else if ErrorLevel = %MBPS_Stopped%
        return "Stopped"
    else
        return "Undefined"
}

; Returns integer
MB_GetPosition()
{
    SendMessage, WM_USER, MBC_GetPosition, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; position: integer
MB_SetPosition(position)
{
    SendMessage, WM_USER, MBC_SetPosition, position,, MusicBee IPC Interface
    return ErrorLevel
}

; Volume: Value between 0 - 100
; Returns integer
MB_GetVolume()
{
    SendMessage, WM_USER, MBC_GetVolume, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Volume: Value between 0 - 100
; Returns MBError
; volume: integer
MB_SetVolume(volume)
{
    SendMessage, WM_USER, MBC_SetVolume, volume,, MusicBee IPC Interface
    return ErrorLevel
}

; Precise volume: Value between 0 - 10000
; Returns integer
MB_GetVolumep()
{
    SendMessage, WM_USER, MBC_GetVolumep, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Precise volume: Value between 0 - 10000
; Returns MBError
; volume: integer
MB_SetVolumep(volume)
{
    SendMessage, WM_USER, MBC_SetVolumep, volume,, MusicBee IPC Interface
    return ErrorLevel
}

; Floating point volume: Value between 0.0 - 1.0
; Returns float
MB_GetVolumef()
{
    SendMessage, WM_USER, MBC_GetVolumef, 0,, MusicBee IPC Interface
    VarSetCapacity(i, MBIPC_SIZEOFINT)
    NumPut(ErrorLevel, i, 0, "UInt")
    f := NumGet(i, 0, "Float")
    return f
}

; Floating point volume: Value between 0.0 - 1.0
; Returns MBError
; volume: float
MB_SetVolumef(volume)
{
    VarSetCapacity(f, MBIPC_SIZEOFFLOAT)
    NumPut(volume, f, 0, "Float")
    i := NumGet(f, 0, "UInt")
    SendMessage, WM_USER, MBC_SetVolumef, i,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetMute()
{
    SendMessage, WM_USER, MBC_GetMute, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; mute: boolean value
MB_SetMute(mute)
{
    SendMessage, WM_USER, MBC_SetMute, mute,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetShuffle()
{
    SendMessage, WM_USER, MBC_GetShuffle, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; shuffle: boolean value
MB_SetShuffle(shuffle)
{
    SendMessage, WM_USER, MBC_SetShuffle, shuffle,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBRepeatMode
MB_GetRepeat()
{
    SendMessage, WM_USER, MBC_GetRepeat, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; repeat: MBRepeatMode
MB_SetRepeat(repeat)
{
    SendMessage, WM_USER, MBC_SetRepeat, repeat,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetEqualiserEnabled()
{
    SendMessage, WM_USER, MBC_GetEqualiserEnabled, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; enabled: boolean value
MB_SetEqualiserEnabled(enabled)
{
    SendMessage, WM_USER, MBC_SetEqualiserEnabled, enabled,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetDspEnabled()
{
    SendMessage, WM_USER, MBC_GetDspEnabled, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; enabled: boolean value
MB_SetDspEnabled(enabled)
{
    SendMessage, WM_USER, MBC_SetDspEnabled, enabled,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetScrobbleEnabled()
{
    SendMessage, WM_USER, MBC_GetScrobbleEnabled, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; enabled: boolean value
MB_SetScrobbleEnabled(enabled)
{
    SendMessage, WM_USER, MBC_SetScrobbleEnabled, enabled,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_ShowEqualiser()
{
    SendMessage, WM_USER, MBC_ShowEqualiser, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetAutoDjEnabled()
{
    SendMessage, WM_USER, MBC_GetAutoDjEnabled, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetStopAfterCurrentEnabled()
{
    SendMessage, WM_USER, MBC_GetStopAfterCurrentEnabled, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_SetStopAfterCurrentEnabled(enabled)
{
    SendMessage, WM_USER, MBC_SetStopAfterCurrentEnabled, enabled,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetCrossfade()
{
    SendMessage, WM_USER, MBC_GetCrossfade, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; crossfade: boolean value
MB_SetCrossfade(crossfade)
{
    SendMessage, WM_USER, MBC_SetCrossfade, crossfade,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBReplayGainMode
MB_GetReplayGainMode()
{
    SendMessage, WM_USER, MBC_GetReplayGainMode, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; mode: MBReplayGainMode
MB_SetReplayGainMode(mode)
{
    SendMessage, WM_USER, MBC_SetReplayGainMode, mode,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_QueueRandomTracks(count)
{
    SendMessage, WM_USER, MBC_QueueRandomTracks, count,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns integer
MB_GetDuration()
{
    SendMessage, WM_USER, MBC_GetDuration, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns string
MB_GetFileUrl()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetFileUrl, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
; fileProperty: MBFileProperty
MB_GetFileProperty(fileProperty)
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetFileProperty, fileProperty,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
; field: MBMetaData
MB_GetFileTag(field)
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetFileTag, field,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetLyrics()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetLyrics, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetDownloadedLyrics()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetDownloadedLyrics, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetArtwork()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetArtwork, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetArtworkUrl()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetArtworkUrl, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetDownloadedArtwork()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetDownloadedArtwork, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetDownloadedArtworkUrl()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetDownloadedArtworkUrl, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
; fadingPercent: integer
MB_GetArtistPicture(fadingPercent)
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetArtistPicture, fadingPercent,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBError
; localOnly: boolean value
MB_GetArtistPictureUrls(localOnly, ByRef urls)
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    r := MBE_Error

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetArtistPictureUrls, localOnly,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), urls)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_GetArtistPictureThumb()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetArtistPictureThumb, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns boolean value
MB_IsSoundtrack()
{
    SendMessage, WM_USER, MBC_IsSoundtrack, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; localOnly: boolean value
MB_GetSoundtrackPictureUrls(localOnly, ByRef urls)
{
    r := MBE_Error

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_GetSoundtrackPictureUrls, localOnly,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), urls)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns integer
MB_GetCurrentIndex()
{
    SendMessage, WM_USER, MBC_GetCurrentIndex, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns integer
; offset: integer
MB_GetNextIndex(offset)
{
    SendMessage, WM_USER, MBC_GetNextIndex, offset,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_IsAnyPriorTracks()
{
    SendMessage, WM_USER, MBC_IsAnyPriorTracks, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_IsAnyFollowingTracks()
{
    SendMessage, WM_USER, MBC_IsAnyFollowingTracks, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; fileurl: string
MB_PlayNow(ByRef fileurl)
{
    MBIPC_Pack_s(cds, data, fileurl)

    SendMessage, WM_COPYDATA, MBC_PlayNow, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; fileurl: string
MB_QueueNext(ByRef fileurl)
{
    MBIPC_Pack_s(cds, data, fileurl)

    SendMessage, WM_COPYDATA, MBC_QueueNext, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; fileurl: string
MB_QueueLast(ByRef fileurl)
{
    MBIPC_Pack_s(cds, data, fileurl)

    SendMessage, WM_COPYDATA, MBC_QueueLast, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
MB_ClearNowPlayingList()
{
    SendMessage, WM_USER, MBC_ClearNowPlayingList, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; index: integer
MB_RemoveAt(index)
{
    SendMessage, WM_USER, MBC_RemoveAt, index,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; fromIndices: integer array
; toIndex: integer
MB_MoveFiles(ByRef fromIndices, toIndex)
{
    MBIPC_Pack_iai(cds, data, fromIndices, toIndex)

    SendMessage, WM_COPYDATA, MBC_MoveFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
MB_ShowNowPlayingAssistant()
{
    SendMessage, WM_USER, MBC_ShowNowPlayingAssistant, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetShowTimeRemaining()
{
    SendMessage, WM_USER, MBC_GetShowTimeRemaining, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetShowRatingTrack()
{
    SendMessage, WM_USER, MBC_GetShowRatingTrack, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
MB_GetShowRatingLove()
{
    SendMessage, WM_USER, MBC_GetShowRatingLove, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns boolean value
; button: MBPlayButtonType
MB_GetButtonEnabled(button)
{
    SendMessage, WM_USER, MBC_GetButtonEnabled, button,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; index: integer
MB_Jump(index)
{
    SendMessage, WM_USER, MBC_Jump, index,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; query: string
; result: string array (output)
MB_Search(ByRef query, ByRef result)
{
    return MB_SearchEx(query, "Contains", ["ArtistPeople", "Title", "Album"], result)
}

; Returns MBError
; query: string
; comparison: string
; fields: string array
; result: string array (output)
MB_SearchEx(ByRef query, ByRef comparison, ByRef fields, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Search, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), result)
        r := MBE_NoError
        
    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; query: string
MB_SearchFirst(ByRef query)
{
    return MB_SearchFirstEx(query, "Contains", ["ArtistPeople", "Title", "Album"])
}

; Returns string
; query: string
; comparison: string
; fields: string array
MB_SearchFirstEx(ByRef query, ByRef comparison, ByRef fields)
{
    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_SearchFirst, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; query: string
; result: integer array (output)
MB_SearchIndices(ByRef query, ByRef result)
{
    return MB_SearchIndicesEx(query, "Contains", ["ArtistPeople", "Title", "Album"], result)
}

; Returns MBError
; query: string
; comparison: string
; fields: string array
; result: integer array (output)
MB_SearchIndicesEx(ByRef query, ByRef comparison, ByRef fields, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_SearchIndices, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_ia(MBIPC_GetLResult(el), result)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns integer
; query: string
MB_SearchFirstIndex(ByRef query)
{
    return MB_SearchFirstIndexEx(query, "Contains", ["ArtistPeople", "Title", "Album"])
}

; Returns integer
; query: string
; comparison: string
; fields: string array
MB_SearchFirstIndexEx(ByRef query, ByRef comparison, ByRef fields)
{
    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    SendMessage, WM_COPYDATA, MBC_SearchFirstIndex, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; query: string
MB_SearchAndPlayFirst(ByRef query)
{
    return MB_SearchAndPlayFirstEx(query, "Contains", ["ArtistPeople", "Title", "Album"])
}

; Returns MBError
; query: string
; comparison: string
; fields: string array
MB_SearchAndPlayFirstEx(ByRef query, ByRef comparison, ByRef fields)
{
    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    SendMessage, WM_COPYDATA, MBC_SearchAndPlayFirst, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; index: integer
MB_NowPlayingList_GetListFileUrl(index)
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_NowPlayingList_GetListFileUrl, index,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
; index: integer
; fileProperty: MBFileProperty
MB_NowPlayingList_GetFileProperty(index, fileProperty)
{
    MBIPC_Pack_i(cds, data, index, fileProperty)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_NowPlayingList_GetFileProperty, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; index: integer
; field: MBMetaData
MB_NowPlayingList_GetFileTag(index, field)
{
    MBIPC_Pack_i(cds, data, index, field)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_NowPlayingList_GetFileTag, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; query: string
MB_NowPlayingList_QueryFiles(ByRef query)
{
    MBIPC_Pack_s(cds, data, query)

    SendMessage, WM_COPYDATA, MBC_NowPlayingList_QueryFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
MB_NowPlayingList_QueryGetNextFile()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_NowPlayingList_QueryGetNextFile, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_NowPlayingList_QueryGetAllFiles()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_NowPlayingList_QueryGetAllFiles, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBError
; query: string
; result: string array (output)
MB_NowPlayingList_QueryFilesEx(ByRef query, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_s(cds, data, query)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_NowPlayingList_QueryFilesEx, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), result)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
MB_NowPlayingList_PlayLibraryShuffled()
{
    SendMessage, WM_USER, MBC_NowPlayingList_PlayLibraryShuffled, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns integer
MB_NowPlayingList_GetItemCount()
{
    SendMessage, WM_USER, MBC_NowPlayingList_GetItemCount, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns string
; playlistUrl: string
MB_Playlist_GetName(ByRef playlistUrl)
{
    MBIPC_Pack_s(cds, data, playlistUrl)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Playlist_GetName, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBPlaylistFormat
; playlistUrl: string
MB_Playlist_GetType(ByRef playlistUrl)
{
    MBIPC_Pack_s(cds, data, playlistUrl)

    SendMessage, WM_COPYDATA, MBC_Playlist_GetType, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns boolean value
; playlistUrl: string
; filename: string
MB_Playlist_IsInList(ByRef playlistUrl, ByRef filename)
{
    MBIPC_Pack_s(cds, data, playlistUrl, filename)

    SendMessage, WM_COPYDATA, MBC_Playlist_IsInList, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
MB_Playlist_QueryPlaylists()
{
    SendMessage, WM_USER, MBC_Playlist_QueryPlaylists, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns string
MB_Playlist_QueryGetNextPlaylist()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Playlist_QueryGetNextPlaylist, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBError
; playlistUrl: string
MB_Playlist_QueryFiles(ByRef playlistUrl)
{
    MBIPC_Pack_s(cds, data, playlistUrl)

    SendMessage, WM_COPYDATA, MBC_Playlist_QueryFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
MB_Playlist_QueryGetNextFile()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Playlist_QueryGetNextFile, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_Playlist_QueryGetAllFiles()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Playlist_QueryGetAllFiles, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBError
; playlistUrl: string
; result: string array (output)
MB_Playlist_QueryFilesEx(ByRef playlistUrl, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_s(cds, data, playlistUrl)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Playlist_QueryFilesEx, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), result)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; folderName: string
; playlistName: string
; filenames: string array
MB_Playlist_CreatePlaylist(ByRef folderName, ByRef playlistName, ByRef filenames)
{
    MBIPC_Pack_sssa(cds, data, folderName, playlistName, filenames)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Playlist_CreatePlaylist, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; playlistUrl: string
MB_Playlist_DeletePlaylist(ByRef playlistUrl)
{
    MBIPC_Pack_s(cds, data, playlistUrl)

    SendMessage, WM_COPYDATA, MBC_Playlist_DeletePlaylist, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; playlistUrl: string
; filenames: string array
MB_Playlist_SetFiles(ByRef playlistUrl, ByRef filenames)
{
    MBIPC_Pack_ssa(cds, data, playlistUrl, filenames)

    SendMessage, WM_COPYDATA, MBC_Playlist_SetFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel
 
    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; playlistUrl: string
; filenames: string array
MB_Playlist_AppendFiles(ByRef playlistUrl, ByRef filenames)
{
    MBIPC_Pack_ssa(cds, data, playlistUrl, filenames)

    SendMessage, WM_COPYDATA, MBC_Playlist_AppendFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel
 
    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; playlistUrl: string
; index: integer
MB_Playlist_RemoveAt(ByRef playlistUrl, index)
{
    MBIPC_Pack_si(cds, data, playlistUrl, index)

    SendMessage, WM_COPYDATA, MBC_Playlist_RemoveAt, &cds,, MusicBee IPC Interface
    r := ErrorLevel
 
    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; playlistUrl: string
; fromIndices: integer array
; toIndex: integer
MB_Playlist_MoveFiles(ByRef playlistUrl, ByRef fromIndices, toIndex)
{
    MBIPC_Pack_siai(cds, data, playlistUrl, fromIndices, toIndex)

    SendMessage, WM_COPYDATA, MBC_Playlist_MoveFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel
 
    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; playlistUrl: string
MB_Playlist_PlayNow(ByRef playlistUrl)
{
    MBIPC_Pack_s(cds, data, playlistUrl)

    SendMessage, WM_COPYDATA, MBC_Playlist_PlayNow, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns integer
; playlistUrl: string
MB_Playlist_GetItemCount(ByRef playlistUrl)
{
    MBIPC_Pack_s(cds, data, playlistUrl)

    SendMessage, WM_COPYDATA, MBC_Playlist_GetItemCount, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; fileUrl: string
; fileProperty: MBFileProperty
MB_Library_GetFileProperty(fileUrl, fileProperty)
{
    MBIPC_Pack_si(cds, data, fileUrl, fileProperty)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetFileProperty, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; fileUrl: string
; field: MBMetaData
MB_Library_GetFileTag(fileUrl, field)
{
    MBIPC_Pack_si(cds, data, fileUrl, field)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetFileTag, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; fileUrl: string
; field: MBMetaData
; value: string
MB_Library_SetFileTag(ByRef fileUrl, field, ByRef value)
{
    MBIPC_Pack_sis(cds, data, fileUrl, field, value)

    SendMessage, WM_COPYDATA, MBC_Library_SetFileTag, &cds,, MusicBee IPC Interface
    r := ErrorLevel
 
    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; fileUrl: string
MB_Library_CommitTagsToFile(ByRef fileUrl)
{
    MBIPC_Pack_s(cds, data, fileUrl)

    SendMessage, WM_COPYDATA, MBC_Library_CommitTagsToFile, &cds,, MusicBee IPC Interface
    r := ErrorLevel
 
    MBIPC_Free(cds, data)

    return r
}

; Returns string
; fileUrl: string
MB_Library_GetLyrics(ByRef fileUrl)
{
    MBIPC_Pack_s(cds, data, fileUrl)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetLyrics, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; fileUrl: string
; index: integer
MB_Library_GetArtwork(ByRef fileUrl, index)
{
    MBIPC_Pack_si(cds, data, fileUrl, index)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetArtwork, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; fileUrl: string
; index: integer
MB_Library_GetArtworkUrl(ByRef fileUrl, index)
{
    MBIPC_Pack_si(cds, data, fileUrl, index)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetArtworkUrl, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; artistName: string
; fadingPercent: integer
; fadingColor: integer
MB_Library_GetArtistPicture(ByRef artistName, fadingPercent, fadingColor)
{
    MBIPC_Pack_si(cds, data, artistName, fadingPercent, fadingColor)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetArtistPicture, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; artistName: string
; localOnly: boolean value
; urls: string array (output)
MB_Library_GetArtistPictureUrls(ByRef artistName, localOnly, ByRef urls)
{
    r := MBE_Error

    MBIPC_Pack_sb(cds, data, artistName, localOnly)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetArtistPictureUrls, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), urls)
        r := MBE_NoError
        
    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; artistName: string
MB_Library_GetArtistPictureThumb(ByRef artistName)
{
    MBIPC_Pack_s(cds, data, artistName)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_GetArtistPictureThumb, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; fileUrl: string
; category: MBLibraryCategory
MB_Library_AddFileToLibrary(ByRef fileUrl, category)
{
    MBIPC_Pack_si(cds, data, fileUrl, category)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_AddFileToLibrary, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; query: string
MB_Library_QueryFiles(ByRef query)
{
    MBIPC_Pack_s(cds, data, query)

    SendMessage, WM_COPYDATA, MBC_Library_QueryFiles, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
MB_Library_QueryGetNextFile()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Library_QueryGetNextFile, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
MB_Library_QueryGetAllFiles()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Library_QueryGetAllFiles, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBError
; query: string
; result: string array (output)
MB_Library_QueryFilesEx(ByRef query, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_s(cds, data, query)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_QueryFilesEx, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), result)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; artistName: string
; minimumArtistSimilarityRating: double
MB_Library_QuerySimilarArtists(ByRef artistName, minimumArtistSimilarityRating)
{
    MBIPC_Pack_sd(cds, data, artistName, minimumArtistSimilarityRating)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_QuerySimilarArtists, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; keyTags: string
; valueTags: string
; query: string
MB_Library_QueryLookupTable(ByRef keyTags, ByRef valueTags, ByRef query)
{
    MBIPC_Pack_s(cds, data, keyTags, valueTags, query)

    SendMessage, WM_COPYDATA, MBC_Library_QueryLookupTable, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; key: string
MB_Library_QueryGetLookupTableValue(ByRef key)
{
    MBIPC_Pack_s(cds, data, key)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_QueryGetLookupTableValue, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; index: integer
MB_Library_Jump(index)
{
    SendMessage, WM_USER, MBC_Library_Jump, index,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; query: string
; result: string array (output)
MB_Library_Search(ByRef query, ByRef result)
{
    return MB_Library_SearchEx(query, "Contains", ["ArtistPeople", "Title", "Album"], result)
}

; Returns MBError
; query: string
; comparison: string
; fields: string array
; result: string array (output)
MB_Library_SearchEx(ByRef query, ByRef comparison, ByRef fields, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_Search, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_sa(MBIPC_GetLResult(el), result)
        r := MBE_NoError
        
    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; query: string
MB_Library_SearchFirst(ByRef query)
{
    return MB_Library_SearchFirstEx(query, "Contains", ["ArtistPeople", "Title", "Album"])
}

; Returns string
; query: string
; comparison: string
; fields: string array
MB_Library_SearchFirstEx(ByRef query, ByRef comparison, ByRef fields)
{
    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_SearchFirst, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; query: string
; result: integer array (output)
MB_Library_SearchIndices(ByRef query, ByRef result)
{
    return MB_Library_SearchIndicesEx(query, "Contains", ["ArtistPeople", "Title", "Album"], result)
}

; Returns MBError
; query: string
; comparison: string
; fields: string array
; result: integer array (output)
MB_Library_SearchIndicesEx(ByRef query, ByRef comparison, ByRef fields, ByRef result)
{
    r := MBE_Error

    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_COPYDATA, MBC_Library_SearchIndices, &cds,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_ia(MBIPC_GetLResult(el), result)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    MBIPC_Free(cds, data)

    return r
}

; Returns integer
; query: string
MB_Library_SearchFirstIndex(ByRef query)
{
    return MB_Library_SearchFirstIndexEx(query, "Contains", ["ArtistPeople", "Title", "Album"])
}

; Returns integer
; query: string
; comparison: string
; fields: string array
MB_Library_SearchFirstIndexEx(ByRef query, ByRef comparison, ByRef fields)
{
    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    SendMessage, WM_COPYDATA, MBC_Library_SearchFirstIndex, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; query: string
MB_Library_SearchAndPlayFirst(ByRef query)
{
    return MB_Library_SearchAndPlayFirstEx(query, "Contains", ["ArtistPeople", "Title", "Album"])
}

; Returns MBError
; query: string
; comparison: string
; fields: string array
MB_Library_SearchAndPlayFirstEx(ByRef query, ByRef comparison, ByRef fields)
{
    MBIPC_Pack_sssa(cds, data, query, comparison, fields)

    SendMessage, WM_COPYDATA, MBC_Library_SearchAndPlayFirst, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns string
; field: MBMetaData
MB_Setting_GetFieldName(field)
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Setting_GetFieldName, field,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBDataType
; field: MBMetaData
MB_Setting_GetDataType(field)
{
    SendMessage, WM_USER, MBC_Setting_GetDataType, field,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns HWND
MB_Window_GetHandle()
{
    SendMessage, WM_USER, MBC_Window_GetHandle, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Window_Close()
{
    SendMessage, WM_USER, MBC_Window_Close, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Window_Restore()
{
    SendMessage, WM_USER, MBC_Window_Restore, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Window_Minimize()
{
    SendMessage, WM_USER, MBC_Window_Minimize, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
MB_Window_Maximize()
{
    SendMessage, WM_USER, MBC_Window_Maximize, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; x: integer
; y: integer
MB_Window_Move(x, y)
{
    MBIPC_Pack_i(cds, data, x, y)

    SendMessage, WM_COPYDATA, MBC_Window_Move, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
; w: integer
; h: integer
MB_Window_Resize(w, h)
{
    MBIPC_Pack_i(cds, data, w, h)

    SendMessage, WM_COPYDATA, MBC_Window_Resize, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}

; Returns MBError
MB_Window_BringToFront()
{
    SendMessage, WM_USER, MBC_Window_BringToFront, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; x: integer (output)
; y: integer (output)
MB_Window_GetPosition(ByRef x, ByRef y)
{
    r := MBE_Error

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Window_GetPosition, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_ii(MBIPC_GetLResult(el), x, y)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns string
; w: integer (output)
; h: integer (output)
MB_Window_GetSize(ByRef w, ByRef h)
{
    r := MBE_Error

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_Window_GetSize, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_ii(MBIPC_GetLResult(el), w, h)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBMusicBeeVersion
MB_GetMusicBeeVersion()
{
    SendMessage, WM_USER, MBC_MusicBeeVersion, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns string
MB_GetMusicBeeVersionStr()
{
    SendMessage, WM_USER, MBC_MusicBeeVersion, 0,, MusicBee IPC Interface
    if ErrorLevel = %MBMBV_v2_0%
        return "2.0"
    else if ErrorLevel = %MBMBV_v2_1%
        return "2.1"
    else if ErrorLevel = %MBMBV_v2_2%
        return "2.2"
    else if ErrorLevel = %MBMBV_v2_3%
        return "2.3"
    else
        return "Unknown"
}

; Returns string
MB_GetPluginVersionStr()
{
    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_PluginVersion, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    MBIPC_Unpack_s(MBIPC_GetLResult(el), r)

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    return r
}

; Returns MBError
; major: integer (output)
; minor: integer (output)
MB_GetPluginVersion(ByRef major, ByRef minor)
{
    r := MBE_Error

    MBIPC_hwnd := WinExist("MusicBee IPC Interface")

    SendMessage, WM_USER, MBC_PluginVersion, 0,, ahk_id %MBIPC_hwnd%
    el := ErrorLevel

    if MBIPC_Unpack_s(MBIPC_GetLResult(el), v)
        r := MBE_NoError

    SendMessage, WM_USER, MBC_FreeLRESULT, el,, ahk_id %MBIPC_hwnd%

    if r = %MBE_NoError%
    {
        StringSplit, arr, v, .
        if arr0 < 2
            r := MB_Error
        else
        {
            major := arr1
            minor := arr2
        }
    }

    return r
}

; Returns MBError
MB_Test()
{
    SendMessage, WM_USER, MBC_Test, 0,, MusicBee IPC Interface
    return ErrorLevel
}

; Returns MBError
; text: string
; caption: string
MB_MessageBox(ByRef text, ByRef caption)
{
    MBIPC_Pack_s(cds, data, text, caption)

    SendMessage, WM_COPYDATA, MBC_MessageBox, &cds,, MusicBee IPC Interface
    r := ErrorLevel

    MBIPC_Free(cds, data)

    return r
}
