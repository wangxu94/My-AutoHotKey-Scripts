;----------------------------------------------------------;
;- MusicBeeIPCSDK AHK v2.0.0                              -;
;- Copyright © Kerli Low 2014                             -;
;- This file is licensed under the                        -;
;- BSD 2-Clause License                                   -;
;- See LICENSE_MusicBeeIPCSDK for more information.       -;
;----------------------------------------------------------;

; MBBool
global MB_False    := 0
global MB_True     := 1

; MBError
global MBE_Error                   := 0
global MBE_NoError                 := 1
global MBE_CommandNotRecognized    := 2

; MBPlayState
global MBPS_Undefined  := 0
global MBPS_Loading    := 1
global MBPS_Playing    := 3
global MBPS_Paused     := 6
global MBPS_Stopped    := 7

; MBRepeatMode
global MBRM_None   := 0
global MBRM_All    := 1
global MBRM_One    := 2
   
; MBReplayGainMode
global MBRGM_Off   := 0
global MBRGM_Track := 1
global MBRGM_Album := 2
global MBRGM_Smart := 3

; MBFileProperty
global MBFP_Url                    := 2
global MBFP_Kind                   := 4
global MBFP_Format                 := 5
global MBFP_Size                   := 7
global MBFP_Channels               := 8
global MBFP_SampleRate             := 9
global MBFP_Bitrate                := 10
global MBFP_DateModified           := 11
global MBFP_DateAdded              := 12
global MBFP_LastPlayed             := 13
global MBFP_PlayCount              := 14
global MBFP_SkipCount              := 15
global MBFP_Duration               := 16
global MBFP_NowPlayingListIndex    := 78  ; only has meaning when called from NowPlayingList_* commands
global MBFP_ReplayGainTrack        := 94
global MBFP_ReplayGainAlbum        := 95

; MBMetaData
global MBMD_TrackTitle     := 65
global MBMD_Album          := 30
global MBMD_AlbumArtist    := 31       ; displayed album artist
global MBMD_AlbumArtistRaw := 34       ; stored album artist
global MBMD_Artist         := 32       ; displayed artist
global MBMD_MultiArtist    := 33       ; individual artists separated by a null char
global MBMD_PrimaryArtist  := 19       ; first artist from multi-artist tagged file otherwise displayed artist
global MBMD_Artists                  := 144
global MBMD_ArtistsWithArtistRole    := 145
global MBMD_ArtistsWithPerformerRole := 146
global MBMD_ArtistsWithGuestRole     := 147
global MBMD_ArtistsWithRemixerRole   := 148
global MBMD_Artwork        := 40
global MBMD_BeatsPerMin    := 41
global MBMD_Composer       := 43       ; displayed composer
global MBMD_MultiComposer  := 89       ; individual composers separated by a null char
global MBMD_Comment        := 44
global MBMD_Conductor      := 45
global MBMD_Custom1        := 46
global MBMD_Custom2        := 47
global MBMD_Custom3        := 48
global MBMD_Custom4        := 49
global MBMD_Custom5        := 50
global MBMD_Custom6        := 96
global MBMD_Custom7        := 97
global MBMD_Custom8        := 98
global MBMD_Custom9        := 99
global MBMD_Custom10       := 128
global MBMD_Custom11       := 129
global MBMD_Custom12       := 130
global MBMD_Custom13       := 131
global MBMD_Custom14       := 132
global MBMD_Custom15       := 133
global MBMD_Custom16       := 134
global MBMD_DiscNo         := 52
global MBMD_DiscCount      := 54
global MBMD_Encoder        := 55
global MBMD_Genre          := 59
global MBMD_Genres         := 103
global MBMD_GenreCategory  := 60
global MBMD_Grouping       := 61
global MBMD_Keywords       := 84
global MBMD_HasLyrics      := 63
global MBMD_Lyricist       := 62
global MBMD_Lyrics         := 114
global MBMD_Mood           := 64
global MBMD_Occasion       := 66
global MBMD_Origin         := 67
global MBMD_Publisher      := 73
global MBMD_Quality        := 74
global MBMD_Rating         := 75
global MBMD_RatingLove     := 76
global MBMD_RatingAlbum    := 104
global MBMD_Tempo          := 85
global MBMD_TrackNo        := 86
global MBMD_TrackCount     := 87
global MBMD_Virtual1       := 109
global MBMD_Virtual2       := 110
global MBMD_Virtual3       := 111
global MBMD_Virtual4       := 112
global MBMD_Virtual5       := 113
global MBMD_Virtual6       := 122
global MBMD_Virtual7       := 123
global MBMD_Virtual8       := 124
global MBMD_Virtual9       := 125
global MBMD_Virtual10      := 135
global MBMD_Virtual11      := 136
global MBMD_Virtual12      := 137
global MBMD_Virtual13      := 138
global MBMD_Virtual14      := 139
global MBMD_Virtual15      := 140
global MBMD_Virtual16      := 141
global MBMD_Year           := 88

; MBLibraryCategory
global MBLC_Music       := 0
global MBLC_Audiobook   := 1
global MBLC_Video       := 2
global MBLC_Inbox       := 4

; MBDataType
global MBDT_String      := 0
global MBDT_Number      := 1
global MBDT_DateTime    := 2
global MBDT_Rating      := 3

; MBLyricsType
global MBLT_NotSpecified    := 0
global MBLT_Synchronised    := 1
global MBLT_UnSynchronised  := 2

; MBPlayButtonType
global MBPBT_PreviousTrack   := 0
global MBPBT_PlayPause       := 1
global MBPBT_NextTrack       := 2
global MBPBT_Stop            := 3

; MBPlaylistFormat
global MBPF_Unknown     := 0
global MBPF_M3u         := 1
global MBPF_Xspf        := 2
global MBPF_Asx         := 3
global MBPF_Wpl         := 4
global MBPF_Pls         := 5
global MBPF_Auto        := 7
global MBPF_M3uAscii    := 8
global MBPF_AsxFile     := 9
global MBPF_Radio       := 10
global MBPF_M3uExtended := 11
global MBPF_Mbp         := 12

; MBMusicBeeVersion
global MBMBV_v2_0 := 0
global MBMBV_v2_1 := 1
global MBMBV_v2_2 := 2
global MBMBV_v2_3 := 3

; MBCommand
global MBC_PlayPause                           := 100      ; WM_USER
global MBC_Play                                := 101      ; WM_USER
global MBC_Pause                               := 102      ; WM_USER
global MBC_Stop                                := 103      ; WM_USER
global MBC_StopAfterCurrent                    := 104      ; WM_USER
global MBC_PreviousTrack                       := 105      ; WM_USER
global MBC_NextTrack                           := 106      ; WM_USER
global MBC_StartAutoDj                         := 107      ; WM_USER
global MBC_EndAutoDj                           := 108      ; WM_USER
global MBC_GetPlayState                        := 109      ; WM_USER
global MBC_GetPosition                         := 110      ; WM_USER
global MBC_SetPosition                         := 111      ; WM_USER
global MBC_GetVolume                           := 112      ; WM_USER
global MBC_SetVolume                           := 113      ; WM_USER
global MBC_GetVolumep                          := 114      ; WM_USER
global MBC_SetVolumep                          := 115      ; WM_USER
global MBC_GetVolumef                          := 116      ; WM_USER
global MBC_SetVolumef                          := 117      ; WM_USER
global MBC_GetMute                             := 118      ; WM_USER
global MBC_SetMute                             := 119      ; WM_USER
global MBC_GetShuffle                          := 120      ; WM_USER
global MBC_SetShuffle                          := 121      ; WM_USER
global MBC_GetRepeat                           := 122      ; WM_USER
global MBC_SetRepeat                           := 123      ; WM_USER
global MBC_GetEqualiserEnabled                 := 124      ; WM_USER
global MBC_SetEqualiserEnabled                 := 125      ; WM_USER
global MBC_GetDspEnabled                       := 126      ; WM_USER
global MBC_SetDspEnabled                       := 127      ; WM_USER
global MBC_GetScrobbleEnabled                  := 128      ; WM_USER
global MBC_SetScrobbleEnabled                  := 129      ; WM_USER
global MBC_ShowEqualiser                       := 130      ; WM_USER
global MBC_GetAutoDjEnabled                    := 131      ; WM_USER
global MBC_GetStopAfterCurrentEnabled          := 132      ; WM_USER
global MBC_SetStopAfterCurrentEnabled          := 133      ; WM_USER
global MBC_GetCrossfade                        := 134      ; WM_USER
global MBC_SetCrossfade                        := 135      ; WM_USER
global MBC_GetReplayGainMode                   := 136      ; WM_USER
global MBC_SetReplayGainMode                   := 137      ; WM_USER
global MBC_QueueRandomTracks                   := 138      ; WM_USER
global MBC_GetDuration                         := 139      ; WM_USER
global MBC_GetFileUrl                          := 140      ; WM_USER
global MBC_GetFileProperty                     := 141      ; WM_USER
global MBC_GetFileTag                          := 142      ; WM_USER
global MBC_GetLyrics                           := 143      ; WM_USER
global MBC_GetDownloadedLyrics                 := 144      ; WM_USER
global MBC_GetArtwork                          := 145      ; WM_USER
global MBC_GetArtworkUrl                       := 146      ; WM_USER
global MBC_GetDownloadedArtwork                := 147      ; WM_USER
global MBC_GetDownloadedArtworkUrl             := 148      ; WM_USER
global MBC_GetArtistPicture                    := 149      ; WM_USER
global MBC_GetArtistPictureUrls                := 150      ; WM_USER
global MBC_GetArtistPictureThumb               := 151      ; WM_USER
global MBC_IsSoundtrack                        := 152      ; WM_USER
global MBC_GetSoundtrackPictureUrls            := 153      ; WM_USER
global MBC_GetCurrentIndex                     := 154      ; WM_USER
global MBC_GetNextIndex                        := 155      ; WM_USER
global MBC_IsAnyPriorTracks                    := 156      ; WM_USER
global MBC_IsAnyFollowingTracks                := 157      ; WM_USER
global MBC_PlayNow                             := 158      ; WM_COPYDATA
global MBC_QueueNext                           := 159      ; WM_COPYDATA
global MBC_QueueLast                           := 160      ; WM_COPYDATA
global MBC_RemoveAt                            := 161      ; WM_USER
global MBC_ClearNowPlayingList                 := 162      ; WM_USER
global MBC_MoveFiles                           := 163      ; WM_COPYDATA
global MBC_ShowNowPlayingAssistant             := 164      ; WM_USER
global MBC_GetShowTimeRemaining                := 165      ; WM_USER
global MBC_GetShowRatingTrack                  := 166      ; WM_USER
global MBC_GetShowRatingLove                   := 167      ; WM_USER
global MBC_GetButtonEnabled                    := 168      ; WM_USER
global MBC_Jump                                := 169      ; WM_USER
global MBC_Search                              := 170      ; WM_COPYDATA
global MBC_SearchFirst                         := 171      ; WM_COPYDATA
global MBC_SearchIndices                       := 172      ; WM_COPYDATA
global MBC_SearchFirstIndex                    := 173      ; WM_COPYDATA
global MBC_SearchAndPlayFirst                  := 174      ; WM_COPYDATA
global MBC_NowPlayingList_GetListFileUrl       := 200      ; WM_COPYDATA
global MBC_NowPlayingList_GetFileProperty      := 201      ; WM_COPYDATA
global MBC_NowPlayingList_GetFileTag           := 202      ; WM_COPYDATA
global MBC_NowPlayingList_QueryFiles           := 203      ; WM_COPYDATA
global MBC_NowPlayingList_QueryGetNextFile     := 204      ; WM_USER
global MBC_NowPlayingList_QueryGetAllFiles     := 205      ; WM_USER
global MBC_NowPlayingList_QueryFilesEx         := 206      ; WM_COPYDATA
global MBC_NowPlayingList_PlayLibraryShuffled  := 207      ; WM_USER
global MBC_NowPlayingList_GetItemCount         := 208      ; WM_USER
global MBC_Playlist_GetName                    := 300      ; WM_COPYDATA
global MBC_Playlist_GetType                    := 301      ; WM_COPYDATA
global MBC_Playlist_IsInList                   := 302      ; WM_COPYDATA
global MBC_Playlist_QueryPlaylists             := 303      ; WM_USER
global MBC_Playlist_QueryGetNextPlaylist       := 304      ; WM_USER
global MBC_Playlist_QueryFiles                 := 305      ; WM_COPYDATA
global MBC_Playlist_QueryGetNextFile           := 306      ; WM_USER
global MBC_Playlist_QueryGetAllFiles           := 307      ; WM_USER
global MBC_Playlist_QueryFilesEx               := 308      ; WM_COPYDATA
global MBC_Playlist_CreatePlaylist             := 309      ; WM_COPYDATA
global MBC_Playlist_DeletePlaylist             := 310      ; WM_COPYDATA
global MBC_Playlist_SetFiles                   := 311      ; WM_COPYDATA
global MBC_Playlist_AppendFiles                := 312      ; WM_COPYDATA
global MBC_Playlist_RemoveAt                   := 313      ; WM_COPYDATA
global MBC_Playlist_MoveFiles                  := 314      ; WM_COPYDATA
global MBC_Playlist_PlayNow                    := 315      ; WM_COPYDATA
global MBC_Playlist_GetItemCount               := 316      ; WM_COPYDATA
global MBC_Library_GetFileProperty             := 400      ; WM_COPYDATA
global MBC_Library_GetFileTag                  := 401      ; WM_COPYDATA
global MBC_Library_SetFileTag                  := 402      ; WM_COPYDATA
global MBC_Library_CommitTagsToFile            := 403      ; WM_COPYDATA
global MBC_Library_GetLyrics                   := 404      ; WM_COPYDATA
global MBC_Library_GetArtwork                  := 405      ; WM_COPYDATA
global MBC_Library_GetArtworkUrl               := 406      ; WM_COPYDATA
global MBC_Library_GetArtistPicture            := 407      ; WM_COPYDATA
global MBC_Library_GetArtistPictureUrls        := 408      ; WM_COPYDATA
global MBC_Library_GetArtistPictureThumb       := 409      ; WM_COPYDATA
global MBC_Library_AddFileToLibrary            := 410      ; WM_COPYDATA
global MBC_Library_QueryFiles                  := 411      ; WM_COPYDATA
global MBC_Library_QueryGetNextFile            := 412      ; WM_USER
global MBC_Library_QueryGetAllFiles            := 413      ; WM_USER
global MBC_Library_QueryFilesEx                := 414      ; WM_COPYDATA
global MBC_Library_QuerySimilarArtists         := 415      ; WM_COPYDATA
global MBC_Library_QueryLookupTable            := 416      ; WM_COPYDATA
global MBC_Library_QueryGetLookupTableValue    := 417      ; WM_COPYDATA
global MBC_Library_GetItemCount                := 418      ; WM_USER
global MBC_Library_Jump                        := 419      ; WM_USER
global MBC_Library_Search                      := 420      ; WM_COPYDATA
global MBC_Library_SearchFirst                 := 421      ; WM_COPYDATA
global MBC_Library_SearchIndices               := 422      ; WM_COPYDATA
global MBC_Library_SearchFirstIndex            := 423      ; WM_COPYDATA
global MBC_Library_SearchAndPlayFirst          := 424      ; WM_COPYDATA
global MBC_Setting_GetFieldName                := 700      ; WM_COPYDATA
global MBC_Setting_GetDataType                 := 701      ; WM_COPYDATA
global MBC_Window_GetHandle                    := 800      ; WM_USER
global MBC_Window_Close                        := 801      ; WM_USER
global MBC_Window_Restore                      := 802      ; WM_USER
global MBC_Window_Minimize                     := 803      ; WM_USER
global MBC_Window_Maximize                     := 804      ; WM_USER
global MBC_Window_Move                         := 805      ; WM_USER
global MBC_Window_Resize                       := 806      ; WM_USER
global MBC_Window_BringToFront                 := 807      ; WM_USER
global MBC_Window_GetPosition                  := 808      ; WM_USER
global MBC_Window_GetSize                      := 809      ; WM_USER
global MBC_FreeLRESULT                         := 900      ; WM_USER
global MBC_MusicBeeVersion                     := 995      ; WM_USER
global MBC_PluginVersion                       := 996      ; WM_USER
global MBC_Test                                := 997      ; WM_USER      For debugging purposes
global MBC_MessageBox                          := 998      ; WM_COPYDATA  For debugging purposes
global MBC_Probe                               := 999      ; WM_USER      To test MusicBeeIPC hwnd is valid

; Window Message
global WM_USER     := 0x0400
global WM_COPYDATA := 0x004A
