#ifndef GOAL_CREATOR_TIDYUP_OBJECTS_H
#define GOAL_CREATOR_TIDYUP_OBJECTS_H

#include "continual_planning_executive/goalCreator.h"

namespace nao_actions
{

    class GoalCreatorTidyupObjects : public continual_planning_executive::GoalCreator
    {
    private:
    	static bool worldResetPerformed;
        public:
            GoalCreatorTidyupObjects();
            ~GoalCreatorTidyupObjects();

            virtual bool fillStateAndGoal(SymbolicState & currentState, SymbolicState & goal);
    };

};

#endif

