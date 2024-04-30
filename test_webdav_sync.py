import pytest

from pathlib import Path
import subprocess as sb


def call_subprocess(cmd: str) -> str:
    process = sb.Popen(
        f". lib/webdav_sync;{cmd}",
        shell=True, executable="/bin/bash", stdout=sb.PIPE, stderr=sb.STDOUT
    )
    output, err = process.communicate(timeout=10)
    assert process.returncode == 0
    return output.decode()


@pytest.fixture
def remote_test_dir() -> str:
    remote_test_dir_path = "Tmp/test_content"
    # clean_remote_test_dir_process  
    call_subprocess(f"_cadaver_call \"rmcol {remote_test_dir_path}\"")
    # create_remote_test_dir_process 
    output = call_subprocess(f"_cadaver_call \"mkdir {remote_test_dir_path}\"")
    assert f"Creating `{remote_test_dir_path}': succeeded." in output
    return remote_test_dir_path


def test_simple_synced_upload(tmpdir, remote_test_dir):
    dummy_content = Path(tmpdir) / "dummy_content"
    nested_content = dummy_content / "nested_content"
    nested_content.mkdir(parents=True)
    dummy_file = dummy_content / "a"
    dummy_file_with_space_in_name = dummy_content / "c C"
    nested_dummy_file = nested_content / "b"
    dummy_file.touch()
    dummy_file_with_space_in_name.touch()
    nested_dummy_file.touch()
    output = call_subprocess(f"list_local_files {dummy_content}")
    assert "a\t0\nc C\t0\n" == output

    # sync_files_to_remote_process
    call_subprocess(f"sync_local_w_remote {dummy_content} {remote_test_dir}")
    
    output = call_subprocess(f"list_remote_files {remote_test_dir}")
    assert "a\t0\nc C\t0\n" == output
    

def test_no_upload_if_target_dir_is_missing(tmpdir):
    remote_test_dir = "invalid_remote_target_dir"
    dummy_content = Path(tmpdir) / "dummy_content"
    dummy_content.mkdir()
    dummy_file = dummy_content / "a"
    dummy_file.touch()
    with pytest.raises(AssertionError):
        call_subprocess(f"sync_local_w_remote {dummy_content} {remote_test_dir}")



def test_upload_only_after_size_change(tmpdir, remote_test_dir):
    dummy_content = Path(tmpdir) / "dummy_content"
    dummy_content.mkdir()
    dummy_file = dummy_content / "a"
    dummy_file.touch()
    # sync_files_to_remote_process
    call_subprocess(f"sync_local_w_remote {dummy_content} {remote_test_dir}")
    
    output = call_subprocess(f"list_remote_files {remote_test_dir}")
    assert "a\t0\n" == output
    
    output = call_subprocess(f"sync_local_w_remote {dummy_content} {remote_test_dir}")
    assert f"Uploading a to `/remote.php/dav/files/grave/{remote_test_dir}/a':" not in output

    dummy_file.write_text("Hello World")

    call_subprocess(f"sync_local_w_remote {dummy_content} {remote_test_dir}")

    output = call_subprocess(f"list_remote_files {remote_test_dir}")
    assert "a\t11\n" == output
