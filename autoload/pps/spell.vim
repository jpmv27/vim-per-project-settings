function pps#spell#configure(activate) abort
    if !exists('g:pps_common_spellfile')
        return
    endif

    if a:activate
        let spell = b:pps_project_dir . '/en.utf-8.add'
        execute 'setlocal spellfile=' . g:pps_common_spellfile . ',' . spell
    else
        execute 'setlocal spellfile=' . g:pps_common_spellfile
    endif
endfunction

