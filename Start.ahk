#Requires AutoHotkey v2.0
; --- AYARLAR ---
txtPath := A_ScriptDir "\metinim.txt"   ; Aynı klasördeki metin dosyası
SendMode "Event"                        ; Tuş taklidi için Event modu (gecikme destekler)
SetKeyDelay 20, 20                      ; Tuşlar arası ve basılı tutma süresi (ms)

; F9 -> "İnsan gibi" yaz (gerçekçi tempo, satır satır + Enter)
F9:: {
    try text := FileRead(txtPath, "UTF-8")  ; Türkçe karakterler için UTF-8
    catch {
        MsgBox "Dosya okunamadı: " txtPath
        return
    }
    for line in StrSplit(text, "`n", "`r") {
        ; Metni özel karakter çevrimi olmadan yazmak için Text modu:
        Send "{Text}" line
        ;Send "{CRTL+J}"
        ;Send, ^j
        ;^j::Send "^j"
        Send("^j")
        Sleep 50   ; satırlar arası çok kısa bekleme
    }
    Send{Enter}
}

; F8 -> Hızlı yaz (yapıştırır gibi, tek seferde)
; Not: Bu modda gecikme ayarı önemsenmez; en hızlısıdır.
F8:: {
    try text := FileRead(txtPath, "UTF-8")
    catch {
        MsgBox "Dosya okunamadı: " txtPath
        return
    }
    SendText text
}

; Ctrl+Esc -> Scripti kapat
^Esc:: ExitApp
