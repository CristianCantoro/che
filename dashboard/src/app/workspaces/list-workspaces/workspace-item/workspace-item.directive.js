/*
 * Copyright (c) 2015-2016 Codenvy, S.A.
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *   Codenvy, S.A. - initial API and implementation
 */
'use strict';

/**
 * Defines a directive for items in workspace list.
 * Expects in parent scope:
 * @param{object} workspace
 */
export class CheWorkspaceItem {

  /**
   * Default constructor.
   */
  constructor() {
    this.restrict = 'E';

    // scope values
    this.scope = {
      workspace: '=cheWorkspaceItem'
    };

    this.templateUrl = 'app/workspaces/list-workspaces/workspace-item/workspace-item.html';


    this.controller = 'WorkspaceItemCtrl';
    this.controllerAs = 'workspaceItemCtrl';
    this.bindToController = true;
  }

}
