#!/usr/bin/env python
#
# Copyright 2014 Huawei Technologies Co. Ltd
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

"""utility switch to virtual env."""
import os
import site
import sys


virtual_env = '/root/.virtualenvs/compass-core'
activate_this = '%s/bin/activate_this.py' % virtual_env
execfile(activate_this, dict(__file__=activate_this))
site.addsitedir('%s/lib/python2.7/site-packages' % virtual_env)
if virtual_env not in sys.path:
    sys.path.append(virtual_env)
os.environ['PYTHON_EGG_CACHE'] = '/tmp/.egg'
