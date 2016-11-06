function! s:spell_dir_path(subdir) abort
    let dir = pps#utils#get_project_dir(1)
    if dir ==# ''
        return ''
    endif

    let dir = dir . '/' . a:subdir
    if !isdirectory(dir)
        return ''
    endif

    return dir
endfunction

function! s:spell_file_path(subdir, name) abort
    let dir = s:spell_dir_path(a:subdir)
    if dir ==# ''
        return ''
    endif

    return dir . '/' . a:name . '.' . &encoding . '.add'
endfunction

function! pps#spell#init() abort
    let s:default_spellfile = &spellfile
endfunction

function! pps#spell#reset() abort
    execute 'setlocal spellfile=' . s:default_spellfile
endfunction

function! pps#spell#enable(subdir) abort
    let spell = s:spell_file_path(a:subdir, split(split(&spelllang, ',')[0], '_')[0])
    if spell ==# ''
        echo 'Could not enable spell per-project settings'
        return
    endif

    execute 'setlocal spellfile+=' . spell
endfunction

function! pps#spell#ref_only(subdir, name) abort
    let spell = s:spell_file_path(a:subdir, a:name)
    if spell ==# ''
        echo 'Could not enable spell per-project settings'
        return
    endif

    if &spellfile ==# ''
        execute 'setlocal spellfile=' . s:spell_file_path(a:subdir, 'dummy')
    endif

    execute 'setlocal spellfile+=' . spell

    return spell
endfunction
