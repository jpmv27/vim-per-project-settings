function! s:spell_file_path(subdir) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    let dir = dir . '/' . a:subdir
    if !isdirectory(dir)
        return ''
    endif

    return dir . '/en.utf-8.add'
endfunction

function! pps#spell#init() abort
    let s:default_spellfile = &spellfile
endfunction

function! pps#spell#reset() abort
    execute 'setlocal spellfile=' . s:default_spellfile
endfunction

function! pps#spell#enable(subdir) abort
    let spell = s:spell_file_path(a:subdir)
    if spell ==# ''
        echo 'Could not enable spell per-project settings'
        return
    endif

    execute 'setlocal spellfile+=' . spell
endfunction

