function pps#apply_settings(project) abort
    let activate = pps#utils#set_project_dir(a:project)

    call pps#vimrc#configure(activate)
    call pps#tags#configure(activate)
    call pps#spell#configure(activate)
endfunction

