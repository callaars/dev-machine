# My dev machine set up in Ansible

## How to use

1. Make sure you got Ansible installed, XCode and have git available.
2. Set the environment variables:
    - `ANSIBLE_SSH_PRIVATE_KEY` - containing your ssh private key.
    - `ANSIBLE_SSH_PUBLIC_KEY` - containing your ssh public key.
    - `ANSIBLE_GPG_PRIVATE_KEY` - containing your gpg private key.
    - `ANSIBLE_GPG_PUBLIC_KEY` - containing your gpg public key.
3. Then run `setup.sh`.
4. Lastly run `ansible-playbook ./playbook.yml`.
5. Optionally if you also need Node.js or Ruby, run the `playbook-node.yml` and `playbook-ruby.yml` respectively.